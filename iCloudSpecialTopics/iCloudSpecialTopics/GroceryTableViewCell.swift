//
//  GroceryTableViewCell.swift
//  iCloudSpecialTopics
//
//  Created by Victor Hawley on 2/29/16.
//  Copyright © 2016 Victor Hawley Jr. All rights reserved.
//

import UIKit

class GroceryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
