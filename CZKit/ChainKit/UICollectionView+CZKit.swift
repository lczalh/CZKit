//
//  ViewController.swift
//  Random
//
//  Created by 刘超正 on 2019/9/20.
//  Copyright © 2019 刘超正. All rights reserved.
//
import Foundation
import UIKit

public extension CZKit where Base: UICollectionView {
    
    @discardableResult
    func backgroundView(_ backgroundView: UIView?) -> CZKit {
        base.backgroundView = backgroundView
        return self
    }
    
    @discardableResult
    func dataSource(_ dataSource: UICollectionViewDataSource?) -> CZKit {
        base.dataSource = dataSource
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UICollectionViewDelegate?) -> CZKit {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func register(_ cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: String) -> CZKit {
        base.register(cellClass, forCellWithReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) -> CZKit {
        base.register(nib, forCellWithReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ viewClass: Swift.AnyClass?,
                  forSupplementaryViewOfKind elementKind: String,
                  withReuseIdentifier identifier: String) -> CZKit {
        base.register(viewClass,
                      forSupplementaryViewOfKind: elementKind,
                      withReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ viewClass: Swift.AnyClass?,
                  forSectionHeaderWithReuseIdentifier identifier: String) -> CZKit {
        base.register(viewClass,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ viewClass: Swift.AnyClass?,
                  forSectionFooterWithReuseIdentifier identifier: String) -> CZKit {
        base.register(viewClass,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ nib: UINib?,
                  forSupplementaryViewOfKind kind: String,
                  withReuseIdentifier identifier: String) -> CZKit {
        base.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ nib: UINib?,
                  forSectionHeaderWithReuseIdentifier identifier: String) -> CZKit {
        base.register(nib,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func register(_ nib: UINib?,
                  forSectionFooterWithReuseIdentifier identifier: String) -> CZKit {
        base.register(nib,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult
    func collectionViewLayout(_ collectionViewLayout: UICollectionViewLayout) -> CZKit {
        base.collectionViewLayout = collectionViewLayout
        return self
    }
}
