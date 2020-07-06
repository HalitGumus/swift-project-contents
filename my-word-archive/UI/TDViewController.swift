//
//  TDViewController.swift
//  TheDatingApp
//
//  Created by HalitGUMUS on 22.09.2019.
//  Copyright © 2019 HalitGUMUS. All rights reserved.
//

import UIKit

class TDViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.defaultBackground
        
        setupUi()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupUi() {
    }
    
    func hideKeyboard(){
        view.endEditing(true)
    }
    
    func setTitleToView(text: String){
        let label = UILabel.init(frame: CGRect(x:68, y:7, width: 240, height: 29))
        label.text = text
        label.font = UIFont(name: "Avenir Next", size: 17)
        label.textColor = .white
        label.textAlignment = .center
        navigationItem.titleView = label
    }
    
    func setTabBarTitleToView(text: String){
        tabBarController?.navigationItem.titleView?.removeFromSuperview()
        let label = UILabel.init(frame: CGRect(x:68, y:7, width: 120, height: 29))
        label.text = text.capitalized
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textColor = .white
        label.textAlignment = .center
        tabBarController?.navigationItem.titleView = label
    }
    
    
}
