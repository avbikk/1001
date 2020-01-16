//
//  ExcusesCircularCollectionViewLayout.swift
//  the1001excuses
//
//  Created by Alsu Bikkulova on 28/12/2019.
//  Copyright © 2019 Alsu Bikkulova. All rights reserved.
//

import UIKit
import CoreGraphics

/// Радиус окружности
let circleRadius: CGFloat = 100

/// Атрибуты для layout
class ExcusesCircularCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var anchorPoint = CGPoint(x: 0, y: 0)
    var angle: CGFloat = 0 {
        didSet {
            zIndex = Int(angle * 1000000)
            transform = CGAffineTransform.init(rotationAngle: angle)
        }
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes: ExcusesCircularCollectionViewLayoutAttributes = super.copy(with: zone) as! ExcusesCircularCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
}


/// Класс для laouyt коллекции - окружность с секторами
class ExcusesCircularCollectionViewLayout: UICollectionViewLayout {

    /// Список параметров
    var attributesList = [ExcusesCircularCollectionViewLayoutAttributes]()
    /// Размеры одной ячейки коллекции
    let itemSize = CGSize(width: 100, height: circleRadius*2)
    
    /// Угол, на который надо повернуть коллекцию
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ? -CGFloat(collectionView!.numberOfItems(inSection: 0) - 1) * anglePerItem : 0
    }

    /// Угол поворота ячейки
    var angle: CGFloat {
        return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize.width - (collectionView!.bounds).width)
    }
    
    /// Радиус окружности
    var radius: CGFloat = circleRadius {
        didSet {
            invalidateLayout()
        }
    }

    /// Угол сектора для каждой ячейки
    var anglePerItem: CGFloat {
        return asin(itemSize.width/(2*radius))
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0)) * itemSize.width, height: (collectionView!.bounds).height)
    }
    
    override class var layoutAttributesClass: AnyClass {
        return ExcusesCircularCollectionViewLayoutAttributes.self
    }
    
    override func prepare() {
        super.prepare()
        
        let centerX = collectionView!.contentOffset.x + (collectionView!.bounds).width / 2.0
        let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
        
        // Get angle
        let theta = atan2((collectionView!.bounds).width / 2.0,
                          radius + (itemSize.height / 2.0) - (collectionView!.bounds).height / 2.0)
        // Set index
        var startIndex = 0
        var endIndex = collectionView!.numberOfItems(inSection: 0) - 1
        // For first index
        if (angle < -theta) {
            startIndex = Int(floor((-theta - angle) / anglePerItem))
        }
        // For last index
        endIndex = min(endIndex, Int(ceil((theta - angle) / anglePerItem)))
        // If end
        if (endIndex < startIndex) {
            endIndex = 0
            startIndex = 0
        }
                
        attributesList = (startIndex...endIndex).map {
            (i) -> ExcusesCircularCollectionViewLayoutAttributes in
            let attributes = ExcusesCircularCollectionViewLayoutAttributes.init(forCellWith: IndexPath(item: i, section: 0))
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: centerX, y: (self.collectionView!.bounds).midY)
            attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
            
            return attributes
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesList[indexPath.row]
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
