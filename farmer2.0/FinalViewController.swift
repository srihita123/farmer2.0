//
//  FinalViewController.swift
//  farmer2.0
//
//  Created by Srihita on 4/30/20.
//  Copyright © 2020 Srihita. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    @IBOutlet weak var produce: UILabel!
    
    @IBOutlet weak var endAuction: UIButton!
    @IBOutlet weak var highestBid: UILabel!
    var localProduce=""

    override func viewDidLoad() {
        super.viewDidLoad()
 appDelegate2 = (UIApplication.shared.delegate as! AppDelegate)
    endAuction.layer.cornerRadius = 25
    endAuction.layer.borderWidth = 1
    endAuction.backgroundColor = .clear
    endAuction.layer.borderColor = UIColor.white.cgColor
}
    
    override func viewWillAppear(_ animated: Bool) {
        let produce=appDelegate2.callProduce
        print( "produce from login" + appDelegate2.callProduce)
        if produce.trimmingCharacters(in: .whitespaces).isEmpty {
            print("Came into if condition:")
        getAuctionByEmail() { dictionary, error in
            DispatchQueue.main.async {
                print("calling getAuctionByEmail" )
                print(dictionary as Any)
                
                var currentBid = ""
            if let val = dictionary!["HighestBid"]  as? NSNumber {

                 
                currentBid = val.stringValue
                print("currentbid: "+currentBid)
                    
                }
             if let min = dictionary!["MinimumPrice"]  as? NSNumber {
                 if currentBid.trimmingCharacters(in: .whitespaces).isEmpty {
                    
                    currentBid = min.stringValue
                    print("inside:"+currentBid)
                    
                 }
                 
             }
                         self.highestBid.text = "Highest Bid: $ " + currentBid
               
                if let produce = dictionary?["Produce"] as? String {
                                             print(produce)
                    self.produce.text = "Produce: " + produce
                    self.localProduce=produce
                    
                                         }
               
                
            }
                
        }
        } else {
            print("Produce:" + appDelegate2.callProduce)
            print("Minimum Price:" + appDelegate2.minimumPrice)
            self.produce.text = "Produce: " + appDelegate2.callProduce
            self.highestBid.text = "Highest Bid: $ \( appDelegate2.minimumPrice)"
        }
    }

    

    func getAuctionByEmail(completionHandler:@escaping ([String:Any]?,Error?)->Void ) {
        print("getAuctionByEmail is called!")
        print("email:"+appDelegate2.callEmail)
              let parameters = [
                          
                          "email":appDelegate2.callEmail
                        
                          ] as [String : Any]
        
               print("called getAuctionByEmail")
               let url1 = URL(string: "http://127.0.0.1:5000/getAuctionByEmail")!
               var request = URLRequest(url:url1)
               request.httpMethod = "POST"
               request.addValue("application/json", forHTTPHeaderField: "Content-Type")
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
                         // print("json data\(json)")
                          if let dictionary = json as? [String: Any] {
                          completionHandler(dictionary,nil)
                        }
                       }catch {
                           print(error)
                       }
                   }
               
               } .resume()
      
        
       

    }
    
    func inactivateBid() {
        var urlString="email=\(appDelegate2.callEmail)&produce=\(self.localProduce)"
           
           var escaped = "http://127.0.0.1:5000/inactivateBid?"+urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
          
         print("URLString:",urlString)
           print("escaped:",escaped)
           let url = URL(string: escaped)
           
           
           var request = URLRequest(url:url!)
           request.httpMethod = "POST"
           //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
          
           // let httpBody = try? JSONSerialization.data(withJSONObject: options:[])
           
           //request.httpBody = ""
           
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
   
    @IBAction func endAuction(_ sender: Any) {
        inactivateBid()
        print("Successfully inactivated")
        
    }
}
