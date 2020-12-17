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
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var txtResi: UILabel!
    @IBOutlet weak var txtPengirim: UILabel!
    @IBOutlet weak var txtPenerima: UILabel!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var lblInfo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewCard.layer.cornerRadius = 10
        viewCard.layer.shadowColor = UIColor.black.cgColor
        viewCard.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewCard.layer.shadowOpacity = 0.7
        viewCard.layer.shadowRadius = 4.0
        viewInfo.layer.cornerRadius = 10
//        txtPengirim.numberOfLines = 0
//        txtPengirim.sizeToFit();
//        txtPenerima.numberOfLines = 0
//        txtPenerima.sizeToFit();
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
