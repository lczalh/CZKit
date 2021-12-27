//
//  UICollectionViewFlowLayout+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UICollectionViewFlowLayout {
    
    @discardableResult
    func layoutAlignment(_ alignment: NSTextAlignment) -> CZKit {
        base.perform(Selector.init(("_setRowAlignmentsOptions:")),with:NSDictionary.init(dictionary:["UIFlowLayoutCommonRowHorizontalAlignmentKey":NSNumber.init(value:alignment.rawValue)]));
        return self
    }
    
    @discardableResult
    func minimumLineSpacing(_ minimumLineSpacing: CGFloat) -> CZKit {
        base.minimumLineSpacing = minimumLineSpacing
        return self
    }
    
    @discardableResult
    func minimumInteritemSpacing(_ minimumInteritemSpacing: CGFloat) -> CZKit {
        base.minimumInteritemSpacing = minimumInteritemSpacing
        return self
    }
    
    @discardableResult
    func itemSize(_ itemSize: CGSize) -> CZKit {
        base.itemSize = itemSize
        return self
    }
    
    @discardableResult
    func itemSize(width: CGFloat, height: CGFloat) -> CZKit {
        base.itemSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func estimatedItemSize(_ estimatedItemSize: CGSize) -> CZKit {
        base.estimatedItemSize = estimatedItemSize
        return self
    }
    
    @discardableResult
    func estimatedItemSize(width: CGFloat, height: CGFloat) -> CZKit {
        base.estimatedItemSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func scrollDirection(_ scrollDirection: UICollectionView.ScrollDirection) -> CZKit {
        base.scrollDirection = scrollDirection
        return self
    }
    
    @discardableResult
    func headerReferenceSize(_ headerReferenceSize: CGSize) -> CZKit {
        base.headerReferenceSize = headerReferenceSize
        return self
    }
    
    @discardableResult
    func headerReferenceSize(width: CGFloat, height: CGFloat) -> CZKit {
        base.headerReferenceSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func footerReferenceSize(_ footerReferenceSize: CGSize) -> CZKit {
        base.footerReferenceSize = footerReferenceSize
        return self
    }
    
    @discardableResult
    func footerReferenceSize(width: CGFloat, height: CGFloat) -> CZKit {
        base.footerReferenceSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func sectionInset(_ sectionInset: UIEdgeInsets) -> CZKit {
        base.sectionInset = sectionInset
        return self
    }
    
    @discardableResult
    func sectionInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> CZKit {
        base.sectionInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
}
