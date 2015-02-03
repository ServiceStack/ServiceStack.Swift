//
//  TabBarController.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/2/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation
import UIKit


class TabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "TechStacks"
        
        var topBarView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        topBarView.backgroundColor = UIColor(red: 3, green: 169, blue: 244, alpha: 1)
        self.view.addSubview(topBarView)

    }
    
    
}

