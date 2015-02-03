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
        let headerController = self.instantiateViewControllerWithIdentifier("Header") as UIViewController
        let view:UIView = headerController.view!
        var frame = view.frame
        frame.size.height = 60
        view.frame = frame
        
        return headerController
    }
    
}