//
//  TechnologyStackDetailViewController.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/5/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit
import Foundation

class TechnologyStackDetailViewController : UIViewController {
    var slug:String!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UITextView!
    @IBOutlet weak var imgScreenshot: UIImageView!
    
    var result:TechStackDetails?
    
    override func viewDidLoad() {
//        tblTechnologyStacks.delegate = self
//        tblTechnologyStacks.dataSource = self
        
        let name = slug.replace("-", withString: " ")
        self.title = "loading \(name)..."
        lblName.text = "loading \(name)..."
        
//        let logoBounds = CGSize(width: view.frame.size.width / 2 - 10, height: imgLogo.frame.size.height)
        
        appData.loadTechnologyStack(slug)
            .then(body: { (r:GetTechnologyStackResponse) -> Void in
                if let result = r.result {
                    self.result = result
                    self.title = "TechStack"
                    self.lblName.text = result.name

                    self.lblDescription.text = result.Description
                    self.lblDescription.sizeToFit()
                    self.imgScreenshot.frame.origin = CGPoint(
                        x: 0,
                        y: self.lblDescription.frame.origin.y + self.lblDescription.frame.height + 8)
                    
                    self.imgScreenshot.loadAsync(result.screenshotUrl, withSize:self.imgScreenshot.frame.size)
                }
//                self.technologyStacks = r.technologyStacks
//                self.tblTechnologyStacks.reloadData()
            })
    }
}