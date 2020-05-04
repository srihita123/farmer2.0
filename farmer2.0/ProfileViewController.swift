//
//  ProfileViewController.swift
//  farmer2.0
//
//  Created by Srihita on 4/4/20.
//  Copyright © 2020 Srihita. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var appDelegate : AppDelegate!
    @IBOutlet weak var title_label: UILabel!
    
    @IBOutlet weak var startAuction: UIButton!
    
    @IBOutlet weak var myAuctions: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAuction.layer.cornerRadius = 25
               startAuction.layer.borderWidth = 1
               startAuction.backgroundColor = .clear
               startAuction.layer.borderColor = UIColor.white.cgColor
        myAuctions.layer.cornerRadius = 25
        myAuctions.layer.borderWidth = 1
        myAuctions.backgroundColor = .clear
        myAuctions.layer.borderColor = UIColor.white.cgColor
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        
     
        
        title_label.text = appDelegate.name
        
       
    }
    
    
   
    }
    


