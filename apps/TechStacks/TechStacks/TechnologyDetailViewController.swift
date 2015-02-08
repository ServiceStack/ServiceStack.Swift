//
//  TechnologyDetailViewController.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/4/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit
import Foundation

class TechnologyDetailViewController : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var slug:String!
    var goBackToTab:MainTab?
    
    var technology:Technology?
    var technologyStacks:[TechnologyStack] = []

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnUrl: UIButton!
    @IBOutlet weak var lblVendor: UILabel!
    @IBOutlet weak var lblDescription: UITextView!
    @IBOutlet weak var imgLogo: UIImageView!

    @IBOutlet weak var tblTechnologyStacks: UITableView!

    @IBAction func btnProductGo() {
        if technology?.productUrl != nil {
            if let url = NSURL(string: technology!.productUrl!) {
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
        tblTechnologyStacks.delegate = self
        tblTechnologyStacks.dataSource = self
        
        let name = slug.replace("-", withString: " ")
        self.title = "loading \(name)..."

        appData.loadTechnology(slug)
            .then(body: { (r:GetTechnologyResponse) -> Void in
                if let technology = r.technology {
                    self.technology = r.technology
                    self.title = "Technology"
                    
                    let pad = Style.padding
                    let fullWidth = self.view.frame.width
                    let halfWidth = fullWidth / 2
                    let innerWidth = fullWidth - (pad * 2)
                    
                    let logoBounds = CGSize(width: self.view.frame.size.width / 2 - (pad * 2), height: self.imgLogo.frame.size.height)

                    self.lblName.text = technology.name
                    self.lblName.font = self.lblName.font.fontWithSize(Style.titleSize)
                    
                    if technology.vendorName != nil && technology.vendorName != technology.name {
                        self.lblVendor.text = "by \(technology.vendorName!)"
                        self.lblVendor.font = self.lblVendor.font.fontWithSize(Style.detailSize)
                        self.lblVendor.frame = CGRect(x: pad, y: self.lblName.frame.size.height + pad, width: halfWidth, height: Style.detailSize.lineHeight)
                    }

                    if let friendlyUrl = technology.productUrl?.toHumanFriendlyUrl() {
                        self.btnUrl.setTitle(friendlyUrl, forState: .Normal)
                    }
                    
                    self.lblDescription.text = technology.Description
                    self.lblDescription.frame = CGRect(
                        x: pad, y: logoBounds.height,
                        width: innerWidth, height: Style.detailSize.lineHeight)
                    self.lblDescription.font = self.lblDescription.font.fontWithSize(Style.detailSize)
                    self.lblDescription.sizeToFit()
                    
                    let tblOffset = self.lblDescription.frame.origin.y + self.lblDescription.frame.height + pad
                    self.tblTechnologyStacks.frame = CGRect(
                        x: 0,
                        y: tblOffset,
                        width: fullWidth, height: self.view.frame.height - tblOffset - 54 /* bottom bar */)

                    self.imgLogo.loadAsync(technology.logoUrl, withSize:logoBounds)
                        .then(body: { (img:UIImage?) -> Void in
                            if img != nil {
                                self.imgLogo.frame.origin = CGPoint(x: fullWidth - img!.size.width - pad, y: 0)
                            }
                        })
                }
                self.technologyStacks = r.technologyStacks
                self.tblTechnologyStacks.reloadData()
            })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return technologyStacks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.createTechnologyStackTableCell(technologyStacks[indexPath.row])
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selected = technologyStacks[indexPath.row]
        
        // Note: Should not be necessary but current iOS 8.0 bug requires it.
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated: false)

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
        self.navigationController?.openTechnologyStack(selected.slug!)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Style.tableCellHeight
    }
}

