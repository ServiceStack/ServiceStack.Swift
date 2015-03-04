//
//  AutoQueryServiceViewController.swift
//  AutoQueryViewer
//
//  Created by Demis Bellot on 2/17/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit


class AutoQueryServiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var lblError: UILabel!
    
    var service:AutoQueryService?
    var response:AutoQueryMetadataResponse?
    var operations = [AutoQueryOperation]()

    var selectedOperation:AutoQueryOperation?

    override func viewDidLoad() {
        
        if let r = response {
            self.loadAutoQueryMetadataResponse(r)
        }
        else if service != nil {
            
            self.loadConfig(service!.toAutoQueryViewerConfig())
            
            var client = JsonServiceClient(baseUrl: service!.serviceBaseUrl!)
            client.getAsync(AutoQueryMetadata())
                .then(body: { (r:AutoQueryMetadataResponse) -> AnyObject in
                    self.loadAutoQueryMetadataResponse(r)
                    return r
                })
                .catch(body: { (e:NSError) -> Void in
                    self.spinner.stopAnimating()
                    self.lblError.text = "host is unavailable"
                })
        }
    }
    
    func loadAutoQueryMetadataResponse(response:AutoQueryMetadataResponse) {
        self.tblView.hidden = false
        self.spinner.stopAnimating()

        self.loadConfig(response.config!)

        self.response = response
        self.operations = response.operations
        self.tblView.reloadData()
    }
    
    func loadConfig(config:AutoQueryViewerConfig)
    {
        lblTitle.text = config.serviceName
        txtDescription.text = config.serviceDescription

        if let textColor = config.textColor {
            lblTitle.textColor = UIColor(rgba: textColor)
            txtDescription.textColor = UIColor(rgba: textColor)
            spinner.color = UIColor(rgba: textColor)
        }
        if let linkColor = config.linkColor {
            btnBack.setTitleColor(UIColor(rgba: linkColor), forState: .Normal)
        }
        if let backgroundColor = config.backgroundColor {
            view.backgroundColor = UIColor(rgba: backgroundColor)
        }
        
        if var brandImageUrl = config.brandImageUrl {
            if brandImageUrl.hasPrefix("/") {
                brandImageUrl = config.serviceBaseUrl!.combinePath(brandImageUrl)
            }
            self.addBrandImage(brandImageUrl, action: "btnBrandGo:")
        }
        
        if var backgroundImageUrl = config.backgroundImageUrl {
            if backgroundImageUrl.hasPrefix("/") {
                backgroundImageUrl = config.serviceBaseUrl!.combinePath(backgroundImageUrl)
            }
            self.imgBackground.loadAsync(backgroundImageUrl, defaultImage:"bg-alpha")
        }
        else {
            self.imgBackground.image = self.appData.imageCache["bg-alpha"]
        }
    }

    func btnBrandGo(sender:UIButton!) {
        let brandUrl = response?.config?.brandUrl
        if brandUrl != nil {
            if let nsUrl = NSURL(string: brandUrl!) {
                UIApplication.sharedApplication().openURL(nsUrl)
            }
        }
    }

    @IBAction func unwindSegue(unwindSegue: UIStoryboardSegue) {
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tblView.dequeueReusableCellWithIdentifier("cellService") as? UITableViewCell
            ?? UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cellService")
        
        if let config = response?.config {
            if let bgColor = config.backgroundColor {
                cell.backgroundColor = UIColor(rgba: bgColor)
            }
            if let textColor = config.textColor {
                cell.textLabel?.textColor = UIColor(rgba: textColor)
                cell.detailTextLabel?.textColor = UIColor(rgba: textColor)
            }
        }

        let op = operations[indexPath.row]
        let opType = response?.getType(op.request)
        
        cell.textLabel?.text = opType?.getViewerAttrProperty("Title")?.value ?? op.request
        cell.detailTextLabel?.text = opType?.getViewerAttrProperty("Description")?.value
        
        cell.imageView!.image = self.appData.imageCache["clearIcon"]
        if let iconUrl = opType?.getViewerAttrProperty("IconUrl")?.value {
            var fullIconUrl = response?.config?.serviceBaseUrl?.combinePath(iconUrl)
            cell.imageView!.loadAsync(fullIconUrl, defaultImage:"clearIcon", withSize: CGSize(width: 50, height: 50))
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let selectedIndex = tblView.indexPathForSelectedRow() {
            tblView.deselectRowAtIndexPath(selectedIndex, animated: false)

            if let autoQueryVC = segue.destinationViewController as? AutoQueryViewController {
                autoQueryVC.selectedOperation = operations[selectedIndex.row]
                autoQueryVC.response = response!
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var autoQueryVC = self.storyboard?.instantiateViewControllerWithIdentifier("AutoQueryViewController") as AutoQueryViewController
        self.addChildViewController(autoQueryVC)
        self.performSegueWithIdentifier("autoquerySegue", sender:self)
    }
}