//
//  BidViewController.swift
//  farmer2.0
//
//  Created by Srihita on 4/28/20.
//  Copyright © 2020 Srihita. All rights reserved.
//

import UIKit

class BidViewController: UIViewController {

     @IBOutlet weak var hbDisplay: UILabel!
    
    var highestBid = appDelegate2.minimumPrice
    var currentBid = appDelegate2.currentBid
  
    
    @IBOutlet weak var submitBid: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate2 = (UIApplication.shared.delegate as! AppDelegate)
        print("BidViewController:" + appDelegate2.minimumPrice)
        if !currentBid.trimmingCharacters(in:.whitespaces).isEmpty {
                     highestBid=currentBid
                 }
        hbDisplay.text = highestBid
        submitBid.layer.cornerRadius = 25
        submitBid.layer.borderWidth = 1
        submitBid.backgroundColor = .clear
        submitBid.layer.borderColor = UIColor.white.cgColor
    }
   
    
    
    
    
    func postJson() {
        var urlString="email=\(appDelegate2.callEmail)&produce=\(appDelegate2.callProduce)&highestbid=\(bidText.text!)"
           
           var escaped = "http://127.0.0.1:5000/updateBid?"+urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
          
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
    @IBOutlet weak var bidText: UITextField!
   
    
    @IBAction func submitBid(_ sender: Any) {
        
        
        if highestBid.trimmingCharacters(in: .whitespaces).isEmpty{
            highestBid=appDelegate2.minimumPrice
        }
       print(bidText.text!+":"+highestBid)
        let highestEntered=Double(bidText.text!) ?? 0
        let delHighestBid=Double(highestBid) ?? 0
        print("\(highestEntered) : \(delHighestBid)")
        if   highestEntered > delHighestBid{
            
            highestBid = bidText.text!
            hbDisplay.text = highestBid
            postJson()
        }else {
            print("Bid is not higher than the highest bid")
        }
    }
    

}
