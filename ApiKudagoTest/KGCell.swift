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

    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var labelDescriotions: UILabel!
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelPlace: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    @IBOutlet weak var kudaGoImage: UIImageView!
    
    
    @IBOutlet weak var viewInCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
 
        // это я сделал тень у своей вьюшки
        shadowView.layer.cornerRadius = 16
        viewInCell.layer.cornerRadius = 16
        viewInCell.layer.masksToBounds = true
        shadowView.applyDropShadow()
        kudaGoImage.layer.masksToBounds = true
     


  
  
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        
        
    }
    

}

extension UIView {
    
    func applyDropShadow(color: UIColor = .black,
                         opacity: Float = 0.15,
                         offset: CGSize = CGSize(width: 0, height: 4),
                         radius: CGFloat = 5,
                         scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
//    // OUTPUT 1
//    func dropShadow(scale: Bool = true) {
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowOffset = CGSize(width: -1, height: 1)
//        layer.shadowRadius = 1
//
//        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
//
//    // OUTPUT 2
//    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
//        layer.masksToBounds = false
//        layer.shadowColor = color.cgColor
//        layer.shadowOpacity = opacity
//        layer.shadowOffset = offSet
//        layer.shadowRadius = radius
//
//        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

