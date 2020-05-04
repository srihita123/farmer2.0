//
//  LoginViewController.swift
//  farmer2.0
//
//  Created by Srihita on 4/19/20.
//  Copyright © 2020 Srihita. All rights reserved.
//

import UIKit
var appDelegate2 : AppDelegate!
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate2 = (UIApplication.shared.delegate as! AppDelegate)
        email.layer.cornerRadius = 25
        password.layer.cornerRadius = 25
        login.layer.cornerRadius = 25
        login.layer.borderWidth = 1
        login.backgroundColor = .clear
        login.layer.borderColor = UIColor.white.cgColor
        
        appDelegate2.name = " "
        appDelegate2.produce = ""
        appDelegate2.callEmail = ""
        appDelegate2.callProduce = " "
        appDelegate2.minimumPrice = ""
        appDelegate2.signUpEmail = " "
        appDelegate2.currentBid = ""
    }
    
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var error: UILabel!
    @IBAction func login_button(_ sender: Any) {
        let url = URL(string: "http://127.0.0.1:5000/get")!
        var buyer:String? = nil
        var seller:String? = nil
        var password:String? = nil
        login(url: url) {dictionary, error in
            DispatchQueue.main.async {
                print("textfield:"+self.password.text!)
                if let password1 = dictionary?["password"] as? String {
                 print(password1)
                    password = password1
                }
                if let buyer1 = dictionary?["buyer"]! as? String {
                    buyer=buyer1
                    print(buyer)
                }
                if let seller1 = dictionary?["seller"]! as? String {
                    seller=seller1
                    print(seller)
                }
                if password == self.password.text  && buyer == "1"
                    {
                    self.performSegue(withIdentifier: "buyerLogin", sender: self)
                        appDelegate2.callEmail = self.email.text!
                                         }
                else if password == self.password.text && seller == "1"
                      {
                    self.performSegue(withIdentifier: "sellerLogin", sender: self)
                        appDelegate2.callEmail = self.email.text!
                                         }
                else {
                    self.error.text = "Wrong email or password: Please try again"
                }
            }
        }  
    }
    
    func login(url: URL,completionHandler:@escaping ([String:Any]?,Error?)->Void ) {
        let parameters = [
                    
                    "email":email.text!,
                    "password":password.text!
                    ] as [String : Any]
         print("called postJson")
         
         var request = URLRequest(url:url)
         request.httpMethod = "POST"
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        var pwd:String? = nil
        var email:String? = nil
        var buyer:String? = nil
        var seller:String? = nil
        
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
                 // let pwd = json?["password"]
                    print("json data\(json)")
                    if let dictionary = json as? [String: Any] {
                        
                        if let password = dictionary["password"] as? String {
                         print(pwd)
                            pwd=password
                        }
                        if let email1 = dictionary["email"] as? String {
                            
                            email=email1
                            print(email1)
                        }
                        if let buyer1 = dictionary["buyer"] as? String {
                            
                            buyer=buyer1
                            print(buyer)
                        }
                        if let seller1 = dictionary["seller"] as? String {
                            
                            seller=seller1
                            print(seller)
                        }
                        
                        for (key, value) in dictionary {
                            print("Key is: \(key) and value is \(value)" )
                        }
                        completionHandler(dictionary,nil)
                    }
                    
                   
                  }catch {
                     print(error)
                 }
             }
         
         } .resume()
            
       
      
        
        
        
    }
    
    
    
   
           
       
  

}
