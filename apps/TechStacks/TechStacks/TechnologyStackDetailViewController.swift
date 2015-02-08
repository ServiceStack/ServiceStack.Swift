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
    
    @IBAction func btnAppUrlGo(sender: AnyObject) {
        if result?.appUrl != nil {
            if let url = NSURL(string: result!.appUrl!) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
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
        let pad = Style.padding
        
        var fullWidth = view.frame.width
        var innerWidth = fullWidth - (pad * 2)
        
        lblName.frame = CGRect(x: pad, y: pad, width: innerWidth, height: Style.titleSize.lineHeight)
        lblName.font = lblName.font.fontWithSize(Style.titleSize)

        lblDescription.frame = CGRect(x: pad, y:pad + lblName.frame.size.height + pad, width:innerWidth, height: Style.detailSize.lineHeight)
        lblDescription.font = lblDescription.font.fontWithSize(Style.detailSize)
        lblDescription.sizeToFit()

        imgScreenshot.frame = CGRect(
            x: (view.frame.size.width - Style.screenshotWidth) / 2,
            y: lblDescription.frame.origin.y + lblDescription.frame.height + pad,
            width: Style.screenshotWidth,
            height: Style.screenshotHeight)
        
        var btnAppUrl = UIButton.buttonWithType(UIButtonType.System) as UIButton
        btnAppUrl.frame = CGRect(x: imgScreenshot.frame.origin.x,
                y: imgScreenshot.frame.origin.y + imgScreenshot.frame.size.height,
                width: imgScreenshot.frame.width,
                height: Style.detailSize.lineHeight)
        btnAppUrl.setTitle(result!.appUrl?.toHumanFriendlyUrl(), forState: .Normal)
        btnAppUrl.addTarget(self, action: "btnAppUrlGo:", forControlEvents: .TouchUpInside)
        scrollView.addSubview(btnAppUrl)
    }
    
    var techSlugs = [String]()

    func loadTechnologies(techChoices:[TechnologyInStack]) {
        var imageUrls = techChoices.filter { $0.logoUrl != nil }.map { $0.logoUrl! }
        let fullWidth = self.view.frame.width
        
        self.appData.loadAllImagesAsync(imageUrls)
            .then(body: { (images:[String:UIImage?]) -> Void in
                let pad = Style.padding
                let btnAppUrlSize:CGFloat = 20
                var startPos = self.imgScreenshot.frame.origin.y + self.imgScreenshot.frame.size.height + pad + btnAppUrlSize
                
                for tier in self.appData.allTiers {
                    let techologiesInTier = techChoices.filter { $0.tier == tier.value }
                    if techologiesInTier.count > 0 {
                        startPos += pad
                        var title = UILabel(frame: CGRectMake(pad, startPos + pad, fullWidth, Style.headingSize.lineHeight))
                        title.font = UIFont(name: title.font.fontName, size: Style.headingSize)
                        startPos += Style.headingSize
                        
                        title.text = tier.title
                        title.textColor = UIColor.lightGrayColor()
                        self.scrollView.addSubview(title)

                        startPos += pad
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
                                startPos += pad
                                let x = i % 2 == 1 ? pad : fullWidth / 2 + pad
                                var imgBtn = UIButton(frame: CGRect(x: x, y: startPos, width: fullWidth / 2 - (2 * pad), height: Style.techLogoHeight))
                                if i % 2 == 0 {
                                    startPos += Style.techLogoHeight
                                }

                                imgBtn.setImage(img!.scaledInto(imgBtn.frame.size), forState: .Normal)
                                self.techSlugs.append(tech.slug!)
                                imgBtn.tag = self.techSlugs.count - 1
                                imgBtn.addTarget(self, action: "onTechnologySelected:", forControlEvents: .TouchUpInside)
                                
                                self.scrollView.addSubview(imgBtn)
                            }
                        }
                        if i % 2 == 1 {
                            startPos += Style.techLogoHeight
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