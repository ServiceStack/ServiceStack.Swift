//
//  StoryBoardExtensions.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/3/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation
import UIKit

// Reusable code shared by different views
extension UIStoryboard {
    
    func headerViewController() -> UIViewController {
        let headerController = self.instantiateViewControllerWithIdentifier("HeaderViewController") as HeaderViewController
        let view:UIView = headerController.view!
        var frame = view.frame
        frame.size.height = 60
        view.frame = frame
        
        return headerController
    }
    
    var tabControler:UITabBarController {
        let window = UIApplication.sharedApplication().keyWindow!
        return window.rootViewController as UITabBarController
    }
    
    func openTechnologyStack(slug:String, goBackToTab:MainTab? = nil) {
        let detail = self.instantiateViewControllerWithIdentifier("TechnologyStackDetailViewController") as TechnologyStackDetailViewController
        detail.slug = slug
        if goBackToTab != nil {
            detail.goBackToTab = goBackToTab
        }
        
        let navController = tabControler.navigationControllerFor(MainTab.TechStacks)!
        navController.popToRootViewControllerAnimated(true)
        navController.pushViewController(detail, animated: true)
        tabControler.switchTab(MainTab.TechStacks)
    }
    
    func openTechnology(slug:String, goBackToTab:MainTab? = nil) {
        let detail = self.instantiateViewControllerWithIdentifier("TechnologyDetailViewController") as TechnologyDetailViewController
        detail.slug = slug
        if goBackToTab != nil {
            detail.goBackToTab = goBackToTab
        }

        let navController = tabControler.navigationControllerFor(MainTab.Technologies)!
        navController.popToRootViewControllerAnimated(true)
        navController.pushViewController(detail, animated: true)
        tabControler.switchTab(MainTab.Technologies)
    }
    
    func switchTab(tab:MainTab) {
        if let window = UIApplication.sharedApplication().keyWindow {
            let tabController = window.rootViewController as? UITabBarController
            tabController?.switchTab(tab)
        }
    }
}

extension UINavigationController
{
    func openTechnologyStack(slug:String) {
        let detail = self.storyboard!.instantiateViewControllerWithIdentifier("TechnologyStackDetailViewController") as TechnologyStackDetailViewController
        detail.slug = slug
        detail.navigationController?.navigationBar.backItem?.title = "Back"
        self.pushViewController(detail, animated: true)
    }
    
    func openTechnology(slug:String) {
        let detail = self.storyboard!.instantiateViewControllerWithIdentifier("TechnologyDetailViewController") as TechnologyDetailViewController
        detail.slug = slug
        detail.navigationController?.navigationBar.backItem?.title = "Back"
        self.pushViewController(detail, animated: true)
    }
}

extension UITabBarController
{
    func switchTab(tab:MainTab) {
        self.selectedIndex = tab.rawValue
    }
    
    func currentNavigationController() -> UINavigationController? {
        return self.viewControllers![self.selectedIndex] as? UINavigationController
    }
    
    func navigationControllerFor(tab:MainTab) -> UINavigationController? {
        return self.viewControllers![tab.rawValue] as? UINavigationController
    }
    
    var currentTab:MainTab {
        return MainTab(rawValue: self.selectedIndex)!
    }
}

enum MainTab : Int
{
    case Home = 0
    case TechStacks = 1
    case Technologies = 2
}
