//
//  PaketTableViewCell.swift
//  paketku
//
//  Created by Garry on 16/12/20.
//  Copyright © 2020 Abhi Wisesa. All rights reserved.
//

import UIKit

class PaketTableViewCell: UITableViewCell {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var txtProduct: UILabel!
    
    @IBOutlet weak var txtResi: UILabel!
    
    @IBOutlet weak var txtStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
