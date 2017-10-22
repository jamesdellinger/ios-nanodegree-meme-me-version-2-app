//
//  MemeTableViewCell.swift
//  MemeMe Version 2.0
//
//  Created by James Dellinger on 10/19/17.
//  Copyright © 2017 James Dellinger. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    // MARK: Table row image view and label outlets
    @IBOutlet weak var tableRowImageView: UIImageView!
    @IBOutlet weak var tableRowLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
