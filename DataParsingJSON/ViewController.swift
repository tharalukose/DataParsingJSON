//
//  ViewController.swift
//  DataParsingJSON
//
//  Created by T Maliackal on 3/11/24.
//

import UIKit

struct Owner {
    //first declare and then initialise
    var reputation : Int?
    var userId : Int?
    var userType : String?
    var profileImg : String?
    var displayName : String?
    var displayImg : String?
    init(obj : NSDictionary){
        //inside owner array values are stored in dictionary form.therefore obj is dictionary
        reputation = obj.value(forKey: "reputation") as? Int
        userId = obj.value(forKey: "user_id") as? Int
        userType = obj.value(forKey: "user_type") as? String
        profileImg = obj.value(forKey: "profile_image") as? String
        displayName = obj.value(forKey: "display_name") as? String
        displayImg = obj.value(forKey: "profile_image") as? String
    }
    
}
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var arr = [Owner]()
    @IBOutlet weak var tableOut: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableOut.delegate = self
        tableOut.dataSource = self
        getData()
        // Do any additional setup after loading the view.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableOut.dequeueReusableCell(withIdentifier: "TheTableViewCell", for: indexPath) as! TheTableViewCell
        let repu = arr[indexPath.row].reputation
        cell.reputationLbl.text = String(repu!)
        let usersId = arr[indexPath.row].userId
        cell.userIdLbl.text = String(usersId!)
        cell.displayNameLbl.text = arr[indexPath.row].displayName
        let img = arr[indexPath.row].displayImg!
        //convert img->data
        let url1 = URL(string: img)!
        let data = NSData(contentsOf: url1)
        cell.displayImage.image = UIImage(data: data as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
    func getData(){
        //API->URL
        let url = URL(string: "https://api.stackexchange.com/2.2/answers?order=desc&sort=activity&site=stackoverflow")
        //whenever parse op is in data, response, error
        URLSession.shared.dataTask(with: url!) { data, response, error in
            do {
                //first curly bracket so NSDictionary
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary {
                    //json of items('items' in api)
                    let itemsArray = json["items"] as? NSArray
                    let ownerArray = itemsArray?.value(forKey: "owner") as? NSArray
                    for i in ownerArray! {
                        self.arr.append(Owner(obj: ((i as? NSDictionary ?? [:]))))
                        
                    }
                }
                DispatchQueue.main.async {
                    //sync - While executing a block after completing the whole block it will get displayed
                    //async
                    //load table
                    //getting value as array .can either have value or do not have value.
                    self.tableOut.reloadData()
                }
            } catch {
                
            }
        }
        //return is same as resume()
        .resume()
    }

}

