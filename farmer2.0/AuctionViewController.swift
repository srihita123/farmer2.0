//
//  AuctionViewController.swift
//  farmer2.0
//
//  Created by Srihita on 4/25/20.
//  Copyright © 2020 Srihita. All rights reserved.
//

import UIKit

class AuctionViewController: UIViewController {
    var appDelegate1 : AppDelegate!
    var appDelegate2 : AppDelegate!
      @IBOutlet weak var produce: UILabel!
    @IBOutlet weak var EMAIL: UILabel!
    @IBOutlet weak var DATE_S: UILabel!
    @IBOutlet weak var IMAGE: UILabel!
    @IBOutlet weak var PRODUCE_D: UILabel!
    @IBOutlet weak var QUANTITY: UILabel!
    @IBOutlet weak var HIGHEST_BID: UILabel!
    
    @IBOutlet weak var startBidding: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var message: UILabel!
    var minimumPrice = ""
    var active = ""
    var bidderEmail = ""
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       startBidding.layer.cornerRadius = 25
        startBidding.layer.borderWidth = 1
        startBidding.backgroundColor = .clear
        startBidding.layer.borderColor = UIColor.white.cgColor
        appDelegate1 = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate2 = (UIApplication.shared.delegate as! AppDelegate)
        getAuction() { dictionary, error in
        DispatchQueue.main.async {
            print("ActionView Controller: in completion hndlers " )
            print(dictionary as Any)
            if let dateStarted = dictionary?["DateStarted"] as? String {
                print("response:" + ((dateStarted )))
                self.DATE_S.text = "Date Started: " + dateStarted
                                     }
            if let email = dictionary?["Email"] as? String {
                                         print(email)
                self.EMAIL.text = "DATE: " + email
                                     }
            if let val = dictionary!["HighestBid"]  as? NSNumber {
                self.HIGHEST_BID.text = "Highest Bid: " + val.stringValue
                self.appDelegate2.currentBid=val.stringValue
            }
            if let image = dictionary?["Image"] as? String {
                                         print(image)
                self.IMAGE.text = image
                                     }
            if let produce = dictionary?["Produce"] as? String {
                                         print(produce)
                self.produce.text = "Produce: " + produce
                self.appDelegate2.callProduce=produce
                                     }
            if let produceDesc = dictionary?["ProduceDesc"] as? String {
                                         print(produceDesc)
                self.PRODUCE_D.text = "Product Description: " + produceDesc
            }
            if let Quantity = dictionary?["Quantity"] as? String {
                                        print(Quantity)
                self.QUANTITY.text = "Quantity: " + Quantity
                                       }
            if let isActive = dictionary?["isActive"] as? String {
                self.active = isActive
                print(isActive)
                
                                   }
            if let bidderEmail = dictionary?["BidderEmail"] as? String {
            self.bidderEmail = bidderEmail
            print(bidderEmail)
            
                               }
            if let minPrice = dictionary?["MinimumPrice"] as? NSNumber {
                print("setting the minimum price:" + minPrice.stringValue)
                self.minimumPrice = minPrice.stringValue
                self.appDelegate1.minimumPrice = minPrice.stringValue
                                     }
            }
            
        }
        image.image = appDelegate2.image
        print("This is the image:", image)
    }
    
     func getAuction(completionHandler:@escaping ([String:Any]?,Error?)->Void ) {
              let parameters = [
                          
                          "produce":appDelegate1.produce
                        
                          ] as [String : Any]
               print("called postJson")
               let url = URL(string: "http://127.0.0.1:5000/getAuction")!
               var request = URLRequest(url:url)
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

    
    @IBOutlet weak var m2: UILabel!
    
    @IBAction func startBidding(_ sender: Any) {
        if (!active.trimmingCharacters(in: .whitespaces).isEmpty && active == "No" ) &&  (!bidderEmail.trimmingCharacters(in: .whitespaces).isEmpty && bidderEmail == appDelegate2.callEmail ) {
            message.text = "You won this auction!"
            m2.text = "We will send an Email with details"
        }
        else if (!active.trimmingCharacters(in: .whitespaces).isEmpty && active == "No" ) {
              message.text = "You didn't win this auction"
        }else{
            performSegue(withIdentifier: "transition", sender: self)
        }
    }
       
}
    
    
   
