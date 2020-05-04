//
//  AuctionFormViewController.swift
//  farmer2.0
//
//  Created by Srihita on 4/28/20.
//  Copyright © 2020 Srihita. All rights reserved.
//

import UIKit

class AuctionFormViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate2 = (UIApplication.shared.delegate as! AppDelegate)
        submit.layer.cornerRadius = 25
        submit.layer.borderWidth = 1
        submit.backgroundColor = .clear
        submit.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBOutlet weak var Produce: UITextField!
    @IBOutlet weak var Quantity: UITextField!
    @IBOutlet weak var Minimum_Price: UITextField!
    @IBOutlet weak var Date_Started: UITextField!
    @IBOutlet weak var Produce_Desc: UITextField!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var submit: UIButton!
    
    
    
    func postJson() {
       // let urlString1 = //"http://127.0.0.1:5000/createAuction?email="+appDelegate2.callEmail+"&produce=a&quantity="+Quantity.text!
       // let urlString2="&DateStarted="+Date_Started.text!
       // let urlString3="&ProduceDesc="+Produce_Desc.text!
      //  var urlString=urlString1+urlString2+urlString3
        var email = appDelegate2.callEmail
        if email == "" {
            email = appDelegate2.signUpEmail
        }
        
        var urlString="email=\(email)&produce=\(Produce.text!)&quantity=\(Quantity.text!)&DateStarted=\(Date_Started.text!)&ProduceDesc=\(Produce_Desc.text!)&minimumPrice=\(Minimum_Price.text!)"
        
        var escaped = "http://127.0.0.1:5000/createAuction?"+urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
       
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

    @IBAction func submit_button(_ sender: Any) {
        appDelegate2.callProduce = Produce.text!
        appDelegate2.minimumPrice = Minimum_Price.text!
        postJson()
        
        
    }
    
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            Image.image = image
            appDelegate2.image = Image.image
        }else{
            //Error
        }
        
        self.dismiss(animated: true , completion: nil)
        
        
        
        
        
        
        
        
    }
}
