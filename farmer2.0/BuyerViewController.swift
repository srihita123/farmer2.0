//
//  BuyerViewController.swift
//  farmer2.0
//
//  Created by Srihita on 4/13/20.
//  Copyright © 2020 Srihita. All rights reserved.
//

import UIKit
 var appDelegate1 : AppDelegate!
 var selectedProduce = "carrot"
class BuyerViewController: UIViewController {

@IBOutlet weak var searchBar: UISearchBar!
@IBOutlet weak var tbView: UITableView!
    let produceArr = ["rice","wheat","corn","tomato","potato","onion","carrot","lettuce","cilantro","mint","eggplant","mango","bell-pepper","cauliflower","cabbage","spinach","chili","garlic","cucumber","okra","broccoli","ginger","avocado","peas","beans","beetroot"]

    var searchProduce = [String]()
    var searching = false
    override func viewDidLoad() {
        appDelegate1 = (UIApplication.shared.delegate as! AppDelegate)
        super.viewDidLoad()

        
    }
    

 
}
extension BuyerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        if searching {
            return searchProduce.count
        } else{
            return produceArr.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if searching {
            cell?.textLabel?.text = searchProduce[indexPath.row]
        } else {
            cell?.textLabel?.text = produceArr[indexPath.row]
            
        }
        
        return cell!
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         print("preparing:" + selectedProduce)
       appDelegate1.produce = selectedProduce
         print("The produce is :" + appDelegate1.produce)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row: \(searchProduce)")
        print("selectedProduce:"+produceArr[indexPath.row])
        selectedProduce = searchProduce[0]
        print("selected produce: "+selectedProduce)
        
      performSegue(withIdentifier: "auction", sender: self)
        
        
    }
    
}
extension BuyerViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
        searchProduce = produceArr.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tbView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tbView.reloadData()
    }
    
    
}
