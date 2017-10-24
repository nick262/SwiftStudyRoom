//
//  NKTableViewCell.swift
//  Project01-Contacts
//
//  Created by Nick Wang on 24/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class NKTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
