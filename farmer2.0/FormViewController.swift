//
//  FormViewController.swift
//  farmer2.0
//
//  Created by Srihita on 4/2/20.
//  Copyright © 2020 Srihita. All rights reserved.
//

import UIKit
var appDelegate : AppDelegate!

class FormViewController: UIViewController{
    var name:[String] = []
    var password:[String] = []
    var email:[String] = []
    var sellerButton = false
    var buyerButton = false
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var name_text: UITextField!
    @IBOutlet weak var password_text: UITextField!
    @IBOutlet weak var email_text: UITextField!
    
   
    @IBOutlet weak var buyer_button: UIButton!
    @IBOutlet weak var seller_button: UIButton!
    @IBAction func buyer_button(_ sender: Any) {

        appDelegate.signUpEmail = email_text.text!
        buyer_button.isEnabled = true
        seller_button.isEnabled = false
        seller_button.setTitleColor(.lightGray, for: .normal)
        buyer_button.setTitleColor(UIColor(displayP3Red: 0.0/255.0, green: 63.0/255.0, blue: 131.0/255.0, alpha: 1.0), for: .normal)
        
    }
    @IBAction func seller_button(_ sender: Any) {
        buyer_button.isEnabled = false
        seller_button.isEnabled = true
        buyer_button.setTitleColor(.lightGray, for: .normal)
        seller_button.setTitleColor(UIColor(displayP3Red: 0.0/255.0, green: 63.0/255.0, blue: 131.0/255.0, alpha: 1.0), for: .normal)
    }
    
    func postJson( name: String) {
        let parameters = [
                   "name": name_text.text!,
                   "email":email_text.text!,
                   "password":password_text.text!,
                   "buyer":buyer_button.isEnabled,
                   "seller":seller_button.isEnabled
                   ] as [String : Any]
        print("called postJson")
        let url = URL(string: "http://127.0.0.1:5000/insertJson")!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print(name_text.text!)
       
         let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options:[])
        
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) {(data,response,error) in
            if let response = response{
                print(response)
            }
            if let data=data {
                do{
                    let json = try JSONSerialization.jsonObject(with:data, options: [])
                    print(json)
                }catch {
                    print(error)
                }
            }
        
        } .resume()
           
        
    }
    
    @IBAction func submit_button(_ sender: Any) {
        
    name.append(name_text.text ?? "no_name")
    password.append(password_text.text ?? "no password")
    email.append(email_text.text ?? "no email" )
        print(name)
        print(password)
        print(email)
        appDelegate.callEmail = self.email_text.text!
        if seller_button.isEnabled == true {
            
            performSegue(withIdentifier: "seller", sender: self)
            
        }
    
        else {
            performSegue(withIdentifier: "buyer", sender: self)
        }
        postJson(name: "\(name_text.text)")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 25
               submitButton.layer.borderWidth = 1
               submitButton.backgroundColor = .clear
               submitButton.layer.borderColor = UIColor.white.cgColor
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        appDelegate.name = "Hi " + name_text.text!
    }


}
