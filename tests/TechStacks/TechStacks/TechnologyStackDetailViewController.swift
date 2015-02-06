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
    var goBackToTab:MainTab?
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UITextView!
    @IBOutlet weak var imgScreenshot: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    
    var result:TechStackDetails?
    
    override func viewWillDisappear(animated: Bool) {
        if goBackToTab != nil {
            self.storyboard?.switchTab(goBackToTab!)
        }
    }
    
    override func viewDidLoad() {
        let name = slug.replace("-", withString: " ")
        self.title = "loading \(name)..."
        lblName.text = "loading \(name)..."

        appData.loadTechnologyStack(slug)
            .then(body: { (r:GetTechnologyStackResponse) -> Void in
                if let result = r.result {
                    self.result = result
                    self.title = "TechStack"
                    self.lblName.text = result.name

                    self.lblDescription.text = result.Description
                    
                    self.calculateLayout()
                    
                    self.imgScreenshot.loadAsync(result.screenshotUrl, withSize:self.imgScreenshot.frame.size)
                    
                    self.loadTechnologies(r.result!.technologyChoices)
                }
            })
    }
    
    func calculateLayout() {
        var fullWidth = self.view.frame.width
        var innerWidth = fullWidth - 8 - 8
        
        self.lblName.frame.origin = CGPoint(x: 8, y: 8)
        self.lblName.frame.size = CGSize(width: innerWidth, height: self.lblName.frame.size.height)
        self.lblDescription.frame.origin = CGPoint(x: 8, y: 8 + lblName.frame.size.height + 8)
        self.lblDescription.frame.size = CGSize(width: innerWidth, height: lblDescription.frame.size.height)
        self.lblDescription.sizeToFit()

        self.imgScreenshot.frame.origin = CGPoint(
            x: self.imgScreenshot.frame.origin.x,
            y: self.lblDescription.frame.origin.y + self.lblDescription.frame.height + 8)
    }
    
    var techSlugs = [String]()

    func loadTechnologies(techChoices:[TechnologyInStack]) {
        var imageUrls = techChoices.filter { $0.logoUrl != nil }.map { $0.logoUrl! }
        let fullWidth = self.view.frame.width
        self.appData.loadAllImagesAsync(imageUrls)
            .then(body: { (images:[String:UIImage?]) -> Void in
                var startPos = self.imgScreenshot.frame.origin.y + self.imgScreenshot.frame.size.height
                
                for tier in self.appData.allTiers {
                    let techologiesInTier = techChoices.filter { $0.tier == tier.value }
                    if techologiesInTier.count > 0 {
                        startPos += 8
                        var title = UILabel(frame: CGRectMake(8, startPos + 8, fullWidth, 22))
                        startPos += 22
                        
                        title.text = tier.title
                        title.textColor = UIColor.lightGrayColor()
                        self.scrollView.addSubview(title)

                        startPos += 8
                        var i = 0
                        for tech in techologiesInTier {
                            if tech.logoUrl == nil {
                                continue
                            }
                            if let img = images[tech.logoUrl!] {
                                if img == nil {
                                    continue
                                }
                                i++
                                startPos += 8
                                let x = i % 2 == 1 ? 8 : fullWidth / 2 + 8
                                var imgBtn = UIButton(frame: CGRect(x: x, y: startPos, width: fullWidth / 2 - 16, height: 75))
                                if i % 2 == 0 {
                                    startPos += 75
                                }

                                imgBtn.setImage(img!.scaledInto(imgBtn.frame.size), forState: .Normal)
                                self.techSlugs.append(tech.slug!)
                                imgBtn.tag = self.techSlugs.count - 1
                                imgBtn.addTarget(self, action: "onTechnologySelected:", forControlEvents: .TouchUpInside)
                                
                                self.scrollView.addSubview(imgBtn)
                            }
                        }
                        if i % 2 == 1 {
                            startPos += 75
                        }
                    }
                }
                
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: startPos)
            })
    }
    
    func onTechnologySelected(sender:UIButton) {
        let slug = techSlugs[sender.tag]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
        self.navigationController?.openTechnology(slug)
    }
    
}