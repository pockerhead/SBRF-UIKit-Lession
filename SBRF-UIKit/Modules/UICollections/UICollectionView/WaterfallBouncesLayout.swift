//
//  WaterfallBouncesLayout.swift
//  SBRF-UIKit
//
//  Created by Artem Balashov on 22/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

import UIKit

protocol WaterfallBouncesLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
}

class WaterfallBouncesLayout: UICollectionViewFlowLayout {

    weak var delegate: WaterfallBouncesLayoutDelegate!
   
    fileprivate var animator: UIDynamicAnimator!
    var collisionBehaviour = UICollisionBehavior()
    let behaviourItem = UIDynamicItemBehavior()

    public var enableDynamics: Bool = false
    
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 6
    
    // 3
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    // 4
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    // 5
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override init() {
        super.init()
        self.minimumLineSpacing = 10
        self.minimumLineSpacing = 10
        self.itemSize = CGSize(width: 100, height: 100)
        self.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.animator = UIDynamicAnimator(collectionViewLayout: self)
        self.animator.addBehavior(collisionBehaviour)
        self.collisionBehaviour.collisionMode = .everything
        self.collisionBehaviour.translatesReferenceBoundsIntoBoundary = true
        behaviourItem.elasticity = 0.3
        behaviourItem.allowsRotation = false
        animator.addBehavior(behaviourItem)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.animator = UIDynamicAnimator(collectionViewLayout: self)
    }
    
    override func prepare() {
        super.prepare()
        
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        // 2
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        // 3
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            // 4
            let photoHeight = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
            let height = cellPadding * 2 + photoHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // 6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
        guard enableDynamics else { return }
        if animator.behaviors.count == 2 {
            cache.forEach{ item in
                let behavior = UIAttachmentBehavior(item: item as UIDynamicItem, attachedToAnchor: item.center)
                behavior.length = 0
                behavior.damping = 0.2
                behavior.frequency = 1
                animator.addBehavior(behavior)
                collisionBehaviour.addItem(item)
                behaviourItem.addItem(item)
            }

        }
        
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if enableDynamics {
            return self.animator.items(in: rect) as? [UICollectionViewLayoutAttributes]
        }
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if enableDynamics {
            return self.animator.layoutAttributesForCell(at:indexPath)
        }
        return cache[indexPath.item]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard enableDynamics else { return false }
        guard let scrollView: UIScrollView = self.collectionView,
            let touchLocation = self.collectionView?.panGestureRecognizer.location(in: self.collectionView) else {return false}
        let delta = newBounds.origin.y - scrollView.bounds.origin.y
        
        
        
        animator.behaviors.forEach{ behavior  in
            guard let behavior = behavior as? UIAttachmentBehavior else {return}
            let yDistance = abs(touchLocation.y - behavior.anchorPoint.y)
            guard yDistance < UIScreen.main.bounds.height else {return}
            let xDistance = abs(touchLocation.x - behavior.anchorPoint.x)
            let scrollResistance = (yDistance + xDistance) / 2000
            
            let item = behavior.items.first!
            var itemCenter = item.center
            if delta < 0 {
                itemCenter.y += max(delta, delta * scrollResistance)
            } else {
                itemCenter.y += min(delta, delta * scrollResistance)
            }
            item.center = CGPoint(x: 2.0 * floor((itemCenter.x / 2.0) + 0.5), y: 2.0 * floor((itemCenter.y / 2.0) + 0.5))
            
            animator.updateItem(usingCurrentState: item)
            

        }
        
        return true
    }
    
}


