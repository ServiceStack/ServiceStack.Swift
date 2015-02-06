//
//  TechnologiesViewController.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/4/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit
import Foundation

class TechnologiesViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating,
UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    var resultsController:TechnologySearchResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        resultsController = TechnologySearchResultsController()
        resultsController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.text = appData.search
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        appData.observe(self, properties: [AppData.Property.AllTechnologies])
        appData.loadAllTechnologies()
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        switch keyPath {
        case AppData.Property.AllTechnologies:
            self.tableView.reloadData()
        default: break
        }
    }
    deinit { self.appData.unobserve(self) }
    
    func searchText() -> String {
        return searchController.searchBar.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let search = searchText()
        if search.count > 0 {
            appData.searchTechnologies(search)
                .then(body:{(r:QueryResponse<Technology>) -> Void in
                    if search != self.searchText() {
                        return //stale results
                    }
                    
                    self.resultsController.filteredResults = r.results
                    self.resultsController.tableView.reloadData()
                })
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.allTechnologies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.createTechnologyTableCell(appData.allTechnologies[indexPath.row])
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selected = tableView == self.tableView
            ? appData.allTechnologies[indexPath.row]
            : resultsController.filteredResults[indexPath.row]

        // Note: Should not be necessary but current iOS 8.0 bug requires it.
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated: false)

        self.storyboard?.openTechnology(selected.slug!)
    }
}

class TechnologySearchResultsController : UITableViewController {
    var filteredResults = [Technology]()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.createTechnologyTableCell(filteredResults[indexPath.row])
    }
}

extension UITableView
{
    func createTechnologyTableCell(result:Technology) -> UITableViewCell {
        let cell = self.dequeueReusableCellWithIdentifier("cellTechnology") as? UITableViewCell
            ?? UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cellTechnology")
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = result.name
        
        cell.detailTextLabel?.text = result.Description
        cell.detailTextLabel?.textColor = UIColor.grayColor()
        
        return cell
    }
}
