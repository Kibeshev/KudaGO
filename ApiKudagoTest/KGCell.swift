//
//  KGCell.swift
//  ApiKudagoTest
//
//  Created by Кирилл Кибешев on 04.03.2019.
//  Copyright © 2019 Кирилл Кибешев. All rights reserved.
//

import UIKit

class KGCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelDescriotions: UILabel!
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelPlace: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    @IBOutlet weak var kudaGoImage: UIImageView!
    
    
    @IBOutlet weak var viewInCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // это я сделал тень у своей вьюшки
        viewInCell.layer.shadowColor = UIColor.black.cgColor
        viewInCell.layer.shadowOpacity = 0.5
        viewInCell.layer.shadowOffset = CGSize(width: 10, height: 5)
        viewInCell.layer.shadowRadius = 12
        viewInCell.layer.shadowPath = UIBezierPath(rect: viewInCell.bounds).cgPath
        viewInCell.layer.shouldRasterize = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        viewInCell.layer.cornerRadius = 16
        viewInCell.layer.masksToBounds = true
    }

}
