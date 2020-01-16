//
//  ExcusesCircularCollectionCellCollectionViewCell.swift
//  the1001excuses
//
//  Created by Alsu Bikkulova on 28/12/2019.
//  Copyright © 2019 Alsu Bikkulova. All rights reserved.
//

import UIKit

@objc protocol CollectionViewCellDelegate {
    @objc optional func collectionViewCellTouchesBegan(cell: ExcusesCircularCollectionViewCell, event: UIEvent)
    @objc optional func collectionViewCellTouchesCancelled(cell: ExcusesCircularCollectionViewCell, event: UIEvent)
    @objc optional func collectionViewCellTouchesEnded(cell: ExcusesCircularCollectionViewCell, event: UIEvent)
}

class ExcusesCircularCollectionViewCell: UICollectionViewCell {
        
    var themeLabel: UILabel = UILabel()
    var clickedLocation = CGPoint()
    var path : UIBezierPath!
    var cellMask : CAShapeLayer!
    
    internal var delegate: CollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        path = createTriangleBezierPath(view: self)
        cellMask = CAShapeLayer();
        cellMask.frame = self.bounds
        cellMask.path = path.cgPath
        self.layer.mask = cellMask
    }
    
    func createTriangleBezierPath(view: UIView) -> UIBezierPath {
        let center = CGPoint(x: view.bounds.width/2.0, y: view.bounds.height)
        let radius: CGFloat = view.bounds.height
        
        let halfWidth = view.frame.size.width / 2.0
        let height = view.frame.size.height
        let angle = atan(height/halfWidth)
        let startAngle = 3 * CGFloat(Double.pi) / 2.0 + angle
        let endAngle = 3 * CGFloat(Double.pi) / 2.0 - angle
        
        let magicY = CGFloat(10)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0, y:magicY))
        path.addLine(to: center)
        path.addLine(to: CGPoint(x: view.bounds.width, y: magicY))
        
        path.addArc(withCenter: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        return path
    }
}
