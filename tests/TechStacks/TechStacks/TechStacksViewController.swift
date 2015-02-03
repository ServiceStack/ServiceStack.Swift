//
//  SecondViewController.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/2/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit

class TechStacksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.storyboard!.headerViewController().view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

