//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Akash G Krishnan on 10/09/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {


    @IBOutlet weak var messageBubble: MessageCell!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let mBubble = messageBubble{
            mBubble.layer.cornerRadius = mBubble.frame.size.height / 5
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
