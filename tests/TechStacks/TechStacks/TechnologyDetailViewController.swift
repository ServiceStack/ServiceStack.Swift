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
    
    var technology:Technology?
    var technologyStacks:[TechnologyStack] = []

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnUrl: UIButton!
    @IBOutlet weak var lblVendor: UILabel!
    @IBOutlet weak var lblDescription: UITextView!
    @IBOutlet weak var imgLogo: UIImageView!

    @IBOutlet weak var tblTechnologyStacks: UITableView!
        @IBAction func btnProductGo() {
        if let url = NSURL(string: technology!.productUrl!) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    override func awakeFromNib() {
    }
    
    override func viewWillAppear(animated: Bool) {
        self.btnUrl.titleLabel?.text = ""
        self.lblVendor.text = ""
        self.lblDescription.text = ""
    }
    
    override func viewDidLoad() {
        tblTechnologyStacks.delegate = self
        tblTechnologyStacks.dataSource = self
        
        let name = slug.replace("-", withString: " ")
        self.title = "loading \(name)..."
        
        let logoBounds = CGSize(width: view.frame.size.width / 2 - 10, height: imgLogo.frame.size.height)
        
        appData.loadTechnology(slug)
            .then(body: { (r:GetTechnologyResponse) -> Void in
                if let technology = r.technology {
                    self.technology = r.technology
                    self.title = "Technology"
                    self.lblName.text = technology.name
                    
                    if let friendlyUrl = technology.productUrl?.splitOnFirst("://").last?
                        .stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "/")) {
                        self.btnUrl.setTitle(friendlyUrl, forState: .Normal)
                    }
                    if technology.vendorName != nil && technology.vendorName != technology.name {
                        self.lblVendor.text = "by \(technology.vendorName!)"
                    }
                    
                    self.lblDescription.text = technology.Description
                    self.lblDescription.sizeToFit()
                    self.tblTechnologyStacks.frame.origin = CGPoint(
                        x: 0,
                        y: self.lblDescription.frame.origin.y + self.lblDescription.frame.height + 8)
                    self.tblTechnologyStacks.frame.size = CGSize(
                        width: self.tblTechnologyStacks.frame.size.width, height: self.view.frame.height - self.tblTechnologyStacks.frame.origin.y - 54 /* bottom bar */)

                    self.imgLogo.loadAsync(technology.logoUrl, withSize:logoBounds)
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
        
        /* replace view controller
        UIViewController *newVC = [[UIViewController alloc] init]; // Replace the current view controller
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:[[self navigationController] viewControllers]];
        [viewControllers removeLastObject];
        [viewControllers addObject:newVC];
        [[self navigationController] setViewControllers:viewControllers animated:YES];
        */
    }
}

