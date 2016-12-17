//
//  TableViewCell.swift
//  supermarket
//
//  Created by apple on 2016/10/14.
//  Copyright © 2016年 zoujiahong. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var profileimageview: UIImageView!
    @IBOutlet weak var detaillabel: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
