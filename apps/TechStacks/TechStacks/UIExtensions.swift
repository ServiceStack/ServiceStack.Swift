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
public enum MainTab : Int
{
    case Home = 0
    case TechStacks = 1
    case Technologies = 2
}

public struct Style
{
    public static let titleSize:CGFloat = {
        return iPad() ? 30 : 20
    }()
    
    public static let detailSize:CGFloat = {
        return iPad() ? 16 : 12
    }()

    public static let headingSize:CGFloat = {
        return iPad() ? 26 : 16
    }()

    public static let tableCellHeight:CGFloat = {
        return iPad() ? 70 : 40
    }()
    
    public static let tableCellTitleSize:CGFloat = {
        return iPad() ? 26 : 16
    }()
    
    public static let tableCellDetailSize:CGFloat = {
        return iPad() ? 20 : 14
    }()
    
    public static let padding:CGFloat = {
        return iPad() ? 16 : 8
    }()
    
    public static let techLogoHeight:CGFloat = {
        return iPad() ? 120 : 75
    }()
    
    public static let screenshotHeight:CGFloat = {
        return iPad() ? 420 : 240
    }()
    
    public static let screenshotWidth:CGFloat = {
        return screenshotHeight * 1.25
    }()
}

extension CGFloat
{
    var lineHeight:CGFloat {
        return self + 4
    }
}

func iPad() -> Bool {
    return UIDevice.currentDevice().userInterfaceIdiom == .Pad
}

func deviceSizes(iphone:CGFloat, ipad:CGFloat) -> CGFloat {
    return UIDevice.currentDevice().userInterfaceIdiom == .Pad ? ipad : iphone
}

extension UIStoryboard
{    
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

extension UIView
{
    var appData:AppData {
        return (UIApplication.sharedApplication().delegate as AppDelegate).appData
    }
}

extension UIViewController
{
    var appData:AppData {
        return (UIApplication.sharedApplication().delegate as AppDelegate).appData
    }
    
    func openServiceStack() {
        self.storyboard?.openTechnology("servicestack")
    }
    
    func addLogo() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "logo"), landscapeImagePhone: nil, style: UIBarButtonItemStyle.Done, target: self, action: "openServiceStack")
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

extension UIImageView {
    func loadAsync(url:String?, defaultImage:String? = nil, withSize:CGSize? = nil) -> Promise<UIImage?> {
        if defaultImage != nil {
            self.image = self.appData.imageCache[defaultImage!]
        } else {
            self.image = nil
        }
        
        if url == nil {
            return Promise<UIImage?> { (complete, reject) in complete(nil) }
        }
        
        return self.appData.loadImageAsync(url!)
            .then(body: {(img:UIImage?) -> UIImage? in
                if img != nil {
                    
                    if withSize != nil {
                        self.image = img?.scaledInto(withSize!)
                    } else {
                        self.image = img
                    }
                }
                return self.image
            })
    }
}

extension CGFloat
{
    public func toHexColor(rgbValue:UInt32) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}

extension UIImage
{
    func scaledInto(bounds:CGSize) -> UIImage
    {
        var scaledSize:CGSize = bounds
        
        let ratioX = bounds.width / self.size.width
        let ratioY = bounds.height / self.size.height
        let useRatio = min(ratioX, ratioY)
        
        scaledSize.width = self.size.width * useRatio
        scaledSize.height = self.size.height * useRatio
        
        UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0)
        var scaledImageRect = CGRectMake(0.0, 0.0, scaledSize.width, scaledSize.height)
        self.drawInRect(scaledImageRect)
        var scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
}

extension UILabel
{
    func setFrame(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat) {
        self.frame = self.frame
    }
}

extension String {
    func toHumanFriendlyUrl() -> String {
        if self.count == 0 {
            return ""
        }
        var url = splitOnFirst("://").last!
        return url.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "/"))
    }
}

