//
//  ChatViewController.swift
//  ChatWithParse
//
//  Created by Calvin Chu on 2/20/17.
//  Copyright © 2017 Calvin Chu. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var queries: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.refresh), userInfo: nil, repeats: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let queries = queries {
            return queries.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell", for: indexPath) as! ChatMessageCell
        let query = queries?[indexPath.row]
        cell.messageLabel.text = query?.object(forKey: "text") as! String?
        if let user = query?.object(forKey: "user") as? PFUser {
            cell.userLabel.text = user.username
        } else {
            cell.userLabel.isHidden = true
        }
        
        return cell
    }
    
    func refresh() {
        let query = PFQuery(className:"Message")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                // print("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                /*
                if let objects = objects {
                    for object in objects {
                        print(object["text"])
                    }
                }
                */
                self.queries = objects
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                print("Error: \(error!.localizedDescription)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newMessage(_ sender: Any) {
        let message = PFObject(className:"Message")
        message["text"] = messageTextField.text
        message["user"] = PFUser.current()
        message.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            if (success) {
                // The object has been saved.
                print(message["text"])
            } else {
                // There was a problem, check error.description
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
