//
//  ViewController.swift
//  Yash User Api
//
//  Created by Felix IT on 09/11/22.
//  Copyright © 2022 Felix IT. All rights reserved.
//

import UIKit

struct User : Decodable {
    var id : Int
    var name : String
    var username : String
    var email: String
    var phone : String
    var website : String
    var address : Address
    var company : Company
    
}
struct Address : Decodable {
    var street : String
    var suite : String
    var city : String
    var zipcode : String
    var geo : Geo
}
struct Geo : Decodable {
    var lat : String
    var lng : String
}
struct Company : Decodable {
    var name : String
    var catchPhrase : String
    var bs : String
}
class ViewController: UIViewController {
    var arr : [User] = []
    
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchuser()
    }
//    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {t
//        <#code#>
//    }
    func fetchuser() {
        let str = "https://jsonplaceholder.typicode.com/users"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) {[unowned self] (data, response, error) in
            if error == nil {
                do {
                    self.arr = try JSONDecoder().decode([User].self, from: data!)
                    DispatchQueue.main.async {
                        self.userTableView.reloadData()
                    }
                }catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
}
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let obj = arr[indexPath.row]
//        cell?.textLabel?.text = obj.website
       cell?.textLabel?.text = obj.company.bs
        cell?.detailTextLabel!.text = obj.phone
        return cell!
 }
    
}
