//
//  ExampleMDSpreadViewController.swift
//  AutoQueryViewer
//
//  Created by Demis Bellot on 2/15/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit


func fromA(asciiCode:Int) -> String {
    var s = "\(UnicodeScalar(asciiCode + 97))"
    return s
}

class ExampleMDSpreadViewController: UIViewController, MDSpreadViewDataSource, MDSpreadViewDelegate {
    
    var data:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for (var a = 0; a < 2; a++) {
            var rowSections = NSMutableArray()
            
            for (var b = 0; b < 2; b++) {
                var columnSections = NSMutableArray()
                
                for (var c = 0; c < 20; c++) {
                    var row = NSMutableDictionary()
                    
                    for (var d = 0; d < 5; d++) {
                        var string = NSMutableString(capacity: 10)
                        
                        for (var e = 0; e < 2; e++) {
                            string.appendString("\(fromA(Int(arc4random_uniform(26))))")
                        }
                        
                        row["column\(fromA(a))\(fromA(b))\(fromA(d))"] = string
                    }
                    
                    row["header\(fromA(a))\(fromA(b))"] = "\(c + 1)"
                    
                    columnSections.addObject(row)
                }
                
                rowSections.addObject(columnSections)
            }
            
            data.addObject(rowSections)
        }
        
        var mdView = MDSpreadView(frame: CGRect(x: 20, y: 20, width: self.view.frame.width - 40, height: self.view.frame.height - 40))
        mdView.dataSource = self
        mdView.delegate = self
        self.view.addSubview(mdView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfRowSectionsInSpreadView(aSpreadView:MDSpreadView) -> NSInteger
    {
        return 1
    }
    
    func numberOfColumnSectionsInSpreadView(aSpreadView:MDSpreadView) -> NSInteger
    {
        return 1
    }
    
    func spreadView(aSpreadView:MDSpreadView, numberOfRowsInSection:NSInteger) -> NSInteger
    {
        return 20
    }
    
    func spreadView(aSpreadView:MDSpreadView, numberOfColumnsInSection:NSInteger) -> NSInteger
    {
        return 5
    }
    
    func spreadView(aSpreadView:MDSpreadView, objectValueForRowAtIndexPath rowPath:MDIndexPath, forColumnAtIndexPath columnPath:MDIndexPath) -> AnyObject
    {
        println("spreadView \(rowPath.section) \(columnPath.section)")
        
        let o = data.objectAtIndex(rowPath.section) as NSMutableArray
        let c = o.objectAtIndex(columnPath.section) as NSMutableArray
        let d = c.objectAtIndex(rowPath.row) as NSMutableDictionary
        
        let key = "column\(fromA(rowPath.section))\(fromA(columnPath.section))\(fromA(columnPath.column))"
        return d.objectForKey(key)!
    }
    
    func spreadView(aSpreadView:MDSpreadView, titleForHeaderInColumnSection section:NSInteger, forRowAtIndexPath rowPath:MDIndexPath)  -> AnyObject
    {
        println("spreadView titleForHeader \(rowPath.section) \(section)")
        
        let o = data.objectAtIndex(rowPath.section) as NSMutableArray
        let c = o.objectAtIndex(section) as NSMutableArray
        let d = c.objectAtIndex(rowPath.row) as NSMutableDictionary
        
        let key = "header\(fromA(rowPath.section))\(fromA(section))"
        return d.objectForKey(key)!
    }
    
    func spreadView( aSpreadView:MDSpreadView, titleForHeaderInRowSection section:NSInteger, forColumnAtIndexPath columnPath:MDIndexPath) -> AnyObject
    {
        return "Column \(columnPath.column+1)"
    }
    
    func spreadView(aSpreadView:MDSpreadView, titleForHeaderInRowSection rowSection:NSInteger, forColumnSection columnSection:NSInteger) -> AnyObject
    {
        return "•"
    }
    
    /* Display Customization */
    func spreadView(aSpreadView:MDSpreadView, heightForRowAtIndexPath indexPath:MDIndexPath) -> CGFloat
    {
        return 20
    }
    
    func spreadView(aSpreadView:MDSpreadView, heightForRowHeaderInSection rowSection:NSInteger) -> CGFloat
    {
        return 20
    }
    
    func spreadView(aSpreadView:MDSpreadView, heightForRowFooterInSection rowSection:NSInteger) -> CGFloat
    {
        return 0
    }
    
    func spreadView(aSpreadView:MDSpreadView, widthForColumnAtIndexPath indexPath:MDIndexPath) -> CGFloat
    {
        return 20
    }
    
    func spreadView(aSpreadView:MDSpreadView, widthForColumnHeaderInSection columnSection:NSInteger) -> CGFloat
    {
        return 20
    }
    
    func spreadView(aSpreadView:MDSpreadView, widthForColumnFooterInSection columnSection:NSInteger) -> CGFloat
    {
        return 0
    }
    

    
    //#pragma mark - Sorting
    //
    //- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForHeaderInRowSection:(NSInteger)rowSection forColumnSection:(NSInteger)columnSection
    //{
    //    return [MDSortDescriptor sortDescriptorWithKey:[NSString stringWithFormat:@"header%c%c", (unichar)rowSection + 'a', (unichar)columnSection + 'a'] ascending:YES selector:@selector(localizedStandardCompare:) selectsWholeSpreadView:NO];
    //    }
    //
    //    - (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForHeaderInRowSection:(NSInteger)section forColumnAtIndexPath:(MDIndexPath *)columnPath
    //{
    //    return [MDSortDescriptor sortDescriptorWithKey:[NSString stringWithFormat:@"column%c%c%c", (unichar)section + 'a', (unichar)columnPath.section + 'a', (unichar)columnPath.column + 'a'] ascending:YES selectsWholeSpreadView:NO];
    //    }
    //
    //    - (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForHeaderInColumnSection:(NSInteger)section forRowAtIndexPath:(MDIndexPath *)rowPath
    //{
    //    return nil;
    //    }
    //
    //    //- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForHeaderInRowSection:(NSInteger)rowSection forColumnFooterSection:(NSInteger)columnSection;
    //    //- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForHeaderInColumnSection:(NSInteger)columnSection forRowFooterSection:(NSInteger)rowSection;
    //    //
    //    //- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForFooterInRowSection:(NSInteger)rowSection forColumnSection:(NSInteger)columnSection;
    //    //- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForFooterInRowSection:(NSInteger)section forColumnAtIndexPath:(MDIndexPath *)columnPath;
    //    //- (MDSortDescriptor *)spreadView:(MDSpreadView *)aSpreadView sortDescriptorPrototypeForFooterInColumnSection:(NSInteger)section forRowAtIndexPath:(MDIndexPath *)rowPath;
    //
    //    - (void)spreadView:(MDSpreadView *)aSpreadView sortDescriptorsDidChange:(NSArray *)oldDescriptors
    //{
    //    MDSortDescriptor *firstDescriptor = aSpreadView.sortDescriptors.firstObject;
    //    [(NSMutableArray *)[[data objectAtIndex:firstDescriptor.rowSection] objectAtIndex:firstDescriptor.columnSection] sortUsingDescriptors:aSpreadView.sortDescriptors];
    //    [aSpreadView reloadData];
    //}
    //
    
}

