//
//  ViewController.swift
//  farmer2.0
//
//  Created by Srihita on 2/17/20.
//  Copyright © 2020 Srihita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUp: UIButton!
    
    @IBOutlet weak var login: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUp.layer.cornerRadius = 25
        signUp.layer.borderWidth = 1
        signUp.backgroundColor = .clear
        signUp.layer.borderColor = UIColor.white.cgColor
        login.layer.cornerRadius = 25
               login.layer.borderWidth = 1
               login.backgroundColor = .clear
               login.layer.borderColor = UIColor.white.cgColor
    }

    @IBAction func plus_button(_ sender: Any) {
        
    }

}



