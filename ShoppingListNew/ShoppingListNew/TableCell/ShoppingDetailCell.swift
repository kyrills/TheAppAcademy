//
//  ShoppingCell.swift
//  ShoppingListNew
//
//  Created by Kyrill van Seventer on 18/10/2017.
//  Copyright © 2017 Kyrill van Seventer. All rights reserved.
//

import UIKit

class ShoppingDetailCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
