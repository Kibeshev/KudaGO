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
        // Initialization code
        kudaGoImage.frame = CGRect(x: 2, y: 85, width: 373, height: 427)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        viewInCell.layer.cornerRadius = 16
        viewInCell.layer.masksToBounds = true
        
        // это я сделал тень у своей вьюшки
        viewInCell.layer.shadowColor = UIColor.black.cgColor
        viewInCell.layer.shadowOpacity = 0.5
        viewInCell.layer.shadowOffset = CGSize.zero
        viewInCell.layer.shadowRadius = 12
        viewInCell.layer.shadowPath = UIBezierPath(rect: viewInCell.bounds).cgPath
        viewInCell.layer.shouldRasterize = true
        
        
      
        
        

        // Configure the view for the selected state
    }

}
