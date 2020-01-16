//
//  ExcusesCircularCollectionCellCollectionViewCell.swift
//  the1001excuses
//
//  Created by Alsu Bikkulova on 28/12/2019.
//  Copyright © 2019 Alsu Bikkulova. All rights reserved.
//

import UIKit

class ExcusesCircularCollectionViewCell: UICollectionViewCell {
        
    var themeLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
//        contentView.layer.cornerRadius = 5
//        contentView.layer.borderColor = UIColor.black.cgColor
//        contentView.layer.borderWidth = 1
//        contentView.layer.shouldRasterize = true
//        contentView.layer.rasterizationScale = UIScreen.main.scale
//        contentView.clipsToBounds = true        
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let circularLayoutAttributes = layoutAttributes as! ExcusesCircularCollectionViewLayoutAttributes
        self.layer.anchorPoint = circularLayoutAttributes.anchorPoint
        self.center.y += circularLayoutAttributes.anchorPoint.y
        self.bringSubviewToFront(themeLabel)
    }
    
    public func addThemeLabel(themeTitle: String) {
        themeLabel = UILabel()
        themeLabel.text = themeTitle
        themeLabel.font = UIFont(name: "Arial", size: 20)
        themeLabel.textColor = .black
        themeLabel.transform = CGAffineTransform(rotationAngle: -.pi/2.0)

        self.addSubview(themeLabel)
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        themeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        themeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -25).isActive = true
    }
}
