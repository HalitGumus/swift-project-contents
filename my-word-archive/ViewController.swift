//
//  ViewController.swift
//  my-word-archive
//
//  Created by HalitG on 5.07.2020.
//  Copyright © 2020 HalitG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.defaultBackground
        headerView.backgroundColor = Colors.defaultHeaderBackground
    }

}

