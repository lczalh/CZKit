//
//  UICollectionView+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
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
    func register(_ cellClass: Swift.AnyClass?, forCellWithReuseIdentifier: String) -> CZKit {
        base.register(cellClass, forCellWithReuseIdentifier: forCellWithReuseIdentifier)
        return self
    }
    
    @discardableResult
    func register(_ cellNib: UINib?, forCellWithReuseIdentifier: String) -> CZKit {
        base.register(cellNib, forCellWithReuseIdentifier: forCellWithReuseIdentifier)
        return self
    }
    
    @discardableResult
    func register(_ headerFooterClass: Swift.AnyClass?,
                  forSupplementaryViewOfKind: String,
                  withReuseIdentifier: String) -> CZKit {
        base.register(headerFooterClass,
                      forSupplementaryViewOfKind: forSupplementaryViewOfKind,
                      withReuseIdentifier: withReuseIdentifier)
        return self
    }
    
    @discardableResult
    func register(_ headerClass: Swift.AnyClass?,
                  forHeaderWithReuseIdentifier: String) -> CZKit {
        base.register(headerClass,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: forHeaderWithReuseIdentifier)
        return self
    }

    @discardableResult
    func register(_ footerClass: Swift.AnyClass?,
                  forFooterWithReuseIdentifier: String) -> CZKit {
        base.register(footerClass,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: forFooterWithReuseIdentifier)
        return self
    }
    
    @discardableResult
    func register(_ headerFooterNib: UINib?,
                  forSupplementaryViewOfKind: String,
                  withReuseIdentifier: String) -> CZKit {
        base.register(headerFooterNib, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: withReuseIdentifier)
        return self
    }
    
    @discardableResult
    func register(_ headerNib: UINib?,
                  forHeaderWithReuseIdentifier: String) -> CZKit {
        base.register(headerNib,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: forHeaderWithReuseIdentifier)
        return self
    }
    
    @discardableResult
    func register(_ footerNib: UINib?,
                  forFooterWithReuseIdentifier: String) -> CZKit {
        base.register(footerNib,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: forFooterWithReuseIdentifier)
        return self
    }
    
    @discardableResult
    func collectionViewLayout(_ collectionViewLayout: UICollectionViewLayout) -> CZKit {
        base.collectionViewLayout = collectionViewLayout
        return self
    }
}
