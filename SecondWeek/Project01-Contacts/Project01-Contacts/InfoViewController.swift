//
//  InfoViewController.swift
//  Project01-Contacts
//
//  Created by Nick Wang on 24/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    var contactModel: ContactsModel?
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Info Card"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: nil)
        avatar.layer.cornerRadius = 50
        avatar.layer.masksToBounds = true
        avatar.image = UIImage.init(named: (contactModel?.avatar)!)
        nameLabel.text = contactModel?.name
        let str = (contactModel?.mobile)!
        var newMobile = ""
        for (index,value) in str.characters.enumerated() {
            newMobile.append(value)
            if (index + 1) % 4 == 0{
                newMobile.append("-")
            }
        }
        mobileLabel.text = newMobile
        emailLabel.text = contactModel?.email
        notesLabel.text = contactModel?.notes
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
