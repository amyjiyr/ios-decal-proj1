//
//  AmysTableViewCell.swift
//  TODO
//
//  Created by Amy Ji on 10/19/16.
//  Copyright © 2016 Amy Ji. All rights reserved.
//

import UIKit

class AmysTableViewCell: UITableViewCell {

    
    @IBOutlet var cellTitle: UILabel!
    
    @IBOutlet var cellContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
