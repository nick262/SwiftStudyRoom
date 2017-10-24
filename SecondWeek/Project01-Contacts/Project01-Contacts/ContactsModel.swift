//
//  ContactsModel.swift
//  Project01-Contacts
//
//  Created by Nick Wang on 24/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ContactsModel {
    let avatar: String
    let name: String
    let mobile: String
    let email: String
    let notes: String
    init(avatar:String, name: String, mobile: String, email: String, notes: String) {
        self.avatar = avatar
        self.name = name
        self.mobile = mobile
        self.email = email
        self.notes = notes
    }
    
}

