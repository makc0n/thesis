//
//  ChoiceCollecionViewLayout.swift
//  Thesis
//
//  Created by Максим Василаки on 23.02.2021.
//  Copyright © 2021 Максим Василаки. All rights reserved.
//

import UIKit

class ChoiceCollecionViewLayout: UICollectionViewLayout {
    
    private var cellAttributes: [UICollectionViewLayoutAttributes] = []
    private static let itemSize = CGSize(width: 80, height: 45)
    private static let requiredSpacing = CGFloat(16)
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = self.collectionView else { return .zero }
        guard collectionView.numberOfSections > 0 else { return .zero }
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        guard itemsCount > 0 else { return .zero }
        return Self.contentSize(collectionViewWidth: collectionView.frame.width, forItemsCount: itemsCount)
    }
    
    override func prepare() {
        self.cellAttributes = self.generateAttributes()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.cellAttributes
    }
    
    func generateAttributes() -> [UICollectionViewLayoutAttributes] {
        guard let collectionView = self.collectionView, collectionView.numberOfSections > 0 else { return [] }
        
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        
        guard itemsCount > 0 else { return [] }
        
        var cellsAttributes = [UICollectionViewLayoutAttributes]()
        
        let itemsPerRow = Int(collectionView.frame.width / (Self.itemSize.width + Self.requiredSpacing))
        let resultSpacing = (collectionView.frame.width - (CGFloat(itemsPerRow) * Self.itemSize.width)) / CGFloat(itemsPerRow - 1)
        
        for itemIndex in 0..<itemsCount {
            let column = itemIndex % itemsPerRow
            let row = itemIndex / itemsPerRow
            
            let x = CGFloat(column) * (Self.itemSize.width + resultSpacing)
            let y = CGFloat(row) * (Self.itemSize.height + Self.requiredSpacing)
            
            let indexPath = IndexPath(row: itemIndex, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(origin: CGPoint(x: x, y: y), size: Self.itemSize)
            cellsAttributes.append(attributes)
        }
        
        return cellsAttributes
    }
    
    static func contentSize(collectionViewWidth: CGFloat, forItemsCount itemsCount: Int) -> CGSize {
        guard collectionViewWidth > 0, itemsCount > 0 else { return .zero }
        let itemsPerRow = Int(collectionViewWidth / (itemSize.width + requiredSpacing))
        let rows = (itemsCount / itemsPerRow) + (itemsCount % itemsPerRow > 0 ? 1 : 0)
        
        guard rows > 0 else { return .zero }
        
        let height = CGFloat(rows) * itemSize.height + CGFloat(rows - 1) * requiredSpacing
        return CGSize(width: collectionViewWidth, height: height)
    }
    
}
