//
//  TheTableViewCell.swift
//  DataParsingJSON
//
//  Created by T Maliackal on 3/12/24.
//

import UIKit

class TheTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userIdLbl: UILabel!
    @IBOutlet weak var reputationLbl: UILabel!
    
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var displayNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
