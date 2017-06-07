//
//  OnboardIntroViewController.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 22/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import UIKit

class OnboardIntroViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var scrollContentView: UIView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var pageWidthLayoutConstraint: NSLayoutConstraint!
    
    private var didCreateConstraints = false
    
    
    @IBOutlet var createUserButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    // MARK: Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        // TODO: The explicit classname is required for iOS 8. Remove when no longer supporting iOS 8.
        let className = NSStringFromClass(OnboardIntroViewController.self).components(separatedBy: ".").last
        super.init(nibName: className, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController {
            navigationController.isNavigationBarHidden = true
        }
        
        nextButton.layer.cornerRadius = 5
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor(red: 15, green: 110, blue: 177).cgColor
        
        createUserButton.layer.cornerRadius = 5
        createUserButton.layer.borderWidth = 1
        createUserButton.layer.borderColor = UIColor(red: 15, green: 110, blue: 177).cgColor
        
        scrollView.addSubview(scrollContentView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !didCreateConstraints {
            // All constraints for the added content view are handled manually
            scrollContentView.translatesAutoresizingMaskIntoConstraints = false
            
            // Add top and bottom constraints between the added content view and the scroll view so that they resize together
            let scrollContentTopConstraint = NSLayoutConstraint(
                item:view,
                attribute:NSLayoutAttribute.top,
                relatedBy:NSLayoutRelation.equal,
                toItem:self.scrollContentView,
                attribute:NSLayoutAttribute.top,
                multiplier:1,
                constant:0)
            
            let scrollContentBottomConstraint = NSLayoutConstraint(
                item:view,
                attribute:NSLayoutAttribute.bottom,
                relatedBy:NSLayoutRelation.equal,
                toItem:scrollContentView,
                attribute:NSLayoutAttribute.bottom,
                multiplier:1,
                constant:0)
            
            let scrollContentLeadingConstraint = NSLayoutConstraint(
                item:scrollContentView,
                attribute:NSLayoutAttribute.leading,
                relatedBy:NSLayoutRelation.equal,
                toItem:scrollView,
                attribute:NSLayoutAttribute.leading,
                multiplier:1,
                constant:0)
            
            let scrollContentTrailingConstraint = NSLayoutConstraint(
                item:scrollContentView,
                attribute:NSLayoutAttribute.trailing,
                relatedBy:NSLayoutRelation.equal,
                toItem:scrollView,
                attribute:NSLayoutAttribute.trailing,
                multiplier:1,
                constant:0)
            
            view.addConstraint(scrollContentTopConstraint)
            view.addConstraint(scrollContentBottomConstraint)
            
            scrollView.addConstraint(scrollContentLeadingConstraint)
            scrollView.addConstraint(scrollContentTrailingConstraint)
            
            let screenWidth = UIScreen.main.bounds.size.width
            
            // Convert the frame width to a constraint to ensure it does not shrink
            let widthConstraint = NSLayoutConstraint(
                item:view,
                attribute:NSLayoutAttribute.width,
                relatedBy:NSLayoutRelation.equal,
                toItem:nil,
                attribute:NSLayoutAttribute.notAnAttribute,
                multiplier:1,
                constant:screenWidth)
            
            view.addConstraint(widthConstraint)
            
            pageWidthLayoutConstraint.constant = screenWidth
        }
        
        // Find the best fit (compressed) height for the content and use this height for the scroll view content
        let compressedSize = scrollContentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        scrollView.contentSize = CGSize(width: scrollContentView.frame.size.width, height: compressedSize.height)
        
        view.setNeedsUpdateConstraints()
        view.layoutIfNeeded()
        
        
        
    }
    
    @IBAction func createNewUserTouchUpInside(_ sender: UIButton) {
        let createUserController = OnboardingCreateUserViewController()
        self.navigationController?.pushViewController(createUserController, animated: true)
    }
    
}

// MARK: Scroll View Delegate

extension OnboardIntroViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset
        let pageWidth = scrollView.frame.size.width
        
        // Find the current page, rounded up to a whole page width
        let currentPage = Int(ceil(pos.x/pageWidth))
        
        pageControl.currentPage = currentPage
        
        if pos.x >= scrollView.contentSize.width - scrollView.frame.size.width {
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "test")
            defaults.synchronize()
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}











