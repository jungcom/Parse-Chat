//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Anthony Lee on 10/9/18.
//  Copyright © 2018 anthony. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    var messages = [Message]()
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        // Auto size row height based on cell autolayout constraints
        chatTableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        chatTableView.estimatedRowHeight = 50
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func sendMessage(_ sender: Any) {
        let chatMessage = Message()
        chatMessage.text = messageTextField.text ?? ""
        chatMessage.user = PFUser.current()!
        chatMessage.saveInBackground (block:{ (success, error) in
            if success {
                print("The message was saved!")
                self.messageTextField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        })
    }
    
    @objc func onTimer() {
        // Add code to be run periodically
        if let query = Message.query(){
            query.order(byDescending: "createdAt")
            query.includeKey("user")
            query.limit = 20
            
            // fetch data asynchronously
            query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
                if let posts = posts as! [Message]?{
                    // do something with the array of object returned by the call
                    self.messages = posts
                    print("messages successfully fetched")
                    self.chatTableView.reloadData()
                } else {
                    print(error?.localizedDescription)
                }
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.messageLabel?.text = messages[indexPath.row].text
        if let user = messages[indexPath.row].user as? PFUser{
            cell.userLabel?.text = user.username
        }
        return cell
    }
}
