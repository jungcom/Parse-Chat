//
//  Message.swift
//  Parse Chat
//
//  Created by Anthony Lee on 10/9/18.
//  Copyright © 2018 anthony. All rights reserved.
//

import UIKit
import Parse

class Message: PFObject, PFSubclassing {
    @NSManaged var text: String
    @NSManaged var user: PFUser
    
    class func parseClassName() -> String {
        return "Message"
    }
}
