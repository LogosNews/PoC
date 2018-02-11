//
//  ViewController.swift
//  PoC
//
//  Created by Siddharth Pandiya on 2/10/18.
//  Copyright © 2018 Siddharth Pandiya. All rights reserved.
//

import UIKit
import FacebookLogin


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        view.addSubview(LoginButton(readPermissions: [ .publicProfile ]))

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

