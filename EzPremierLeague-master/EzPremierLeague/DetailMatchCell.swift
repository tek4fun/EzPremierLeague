//
//  DetailMatchCell.swift
//  EzPremierLeague
//
//  Created by iOS Student on 3/20/17.
//  Copyright © 2017 tek4fun. All rights reserved.
//

import UIKit

class DetailMatchCell: UITableViewCell {

    @IBOutlet weak var img_Team1: UIImageView!
    @IBOutlet weak var lbl_Team1: UILabel!
    @IBOutlet weak var lbl_Team1Score: UILabel!
    @IBOutlet weak var img_Team2: UIImageView!
    @IBOutlet weak var lbl_Team2: UILabel!
    @IBOutlet weak var lbl_Team2Score: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
