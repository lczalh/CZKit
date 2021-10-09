//
//  CZCollectionGridViewLayout.swift
//  letaoshijie
//
//  Created by udream3 on 2021/7/15.
//

import UIKit

public class CZCollectionGridViewLayout: UICollectionViewLayout {
    
    public enum DirectionEnum {
        case 水平
        case 垂直
    }
    
    private var computedContentSize: CGSize = .zero
    
    private var cellAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    
    /// 水平间距
    var horizontalSpacing: CGFloat = 10
    
    /// 垂直间距
    var verticalSpacing: CGFloat = 10
    
    /// 每一项的大小
    var itemSize: CGSize = CGSize(width: 50, height: 50)
    
    /// 排列方向
    var direction: DirectionEnum = .水平
    
    /// 是否固定首列
    var isFixedFirstColumn: Bool = true
    
    /// 是否固定首行
    var isFixedFirstRow: Bool = true
    
    public override func prepare() {
        computedContentSize = .zero
        cellAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var contentWidth: CGFloat = 0
        var contentHeight: CGFloat = 0
        
        for section in 0 ..< (collectionView?.numberOfSections ?? 0) {
            for item in 0 ..< (collectionView?.numberOfItems(inSection: section) ?? 0) {
                let itemFrame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = itemFrame
                
                //将表头、首列单元格置为最顶层
                if section == 0 && item == 0 {
                    attributes.zIndex = 1024
                } else if section == 0 || item == 0 {
                    attributes.zIndex = 1023
                }
                
                /// 设置固定首行
                if isFixedFirstRow {
                    if section == 0 {
                        var frame = attributes.frame
                        frame.origin.y = (collectionView?.contentOffset.y ?? 0)
                        attributes.frame = frame
                    }
                }
                
                // 设置固定首列
                if isFixedFirstColumn {
                    if item == 0 {
                        var frame = attributes.frame
                        frame.origin.x = (collectionView?.contentOffset.x ?? 0)
                            + (collectionView?.contentInset.left ?? 0)
                        attributes.frame = frame
                    }
                }
                cellAttributes[indexPath] = attributes
                switch direction {
                case .水平:
                    xOffset += itemSize.width + horizontalSpacing
                case .垂直:
                    yOffset += itemSize.width + horizontalSpacing
                }
            }
            switch direction {
            case .水平:
                // 计算最大宽度
                contentWidth = max(contentWidth, xOffset)
                xOffset = 0
                yOffset += itemSize.height + verticalSpacing
                // 获取最大高度
                contentHeight = max(contentHeight, yOffset)
            case .垂直:
                // 计算最大高度
                contentHeight = max(contentHeight, yOffset)
                yOffset = 0
                xOffset += itemSize.height + verticalSpacing
                // 获取最大宽度
                contentWidth = max(contentWidth, xOffset)
            }
        }
        computedContentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    
    /// 返回内容区域总大小，不是可见区域
    public override var collectionViewContentSize: CGSize {
        return computedContentSize
    }
    
    /// 返回所有单元格位置属性
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributeList = [UICollectionViewLayoutAttributes]()
        for (_, attributes) in cellAttributes {
            if attributes.frame.intersects(rect) {
                attributeList.append(attributes)
            }
        }
        return attributeList
    }
    
    /// 这个方法返回每个单元格的位置和大小
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttributes[indexPath]
    }
    
    /// 改为边界发生任何改变时（包括滚动条改变），都应该刷新布局。
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

public extension CZKit where Base: CZCollectionGridViewLayout {
    
    /// 设置水平间距
    @discardableResult
    func horizontalSpacing(_ spacing: CGFloat) -> CZKit {
        base.horizontalSpacing = spacing
        return self
    }
    
    /// 设置垂直间距
    @discardableResult
    func verticalSpacing(_ spacing: CGFloat) -> CZKit {
        base.verticalSpacing = spacing
        return self
    }
    
    /// 每一项的大小
    @discardableResult
    func itemSize(_ size: CGSize) -> CZKit {
        base.itemSize = size
        return self
    }
    
    /// 排列方向
    @discardableResult
    func direction(_ direction: CZCollectionGridViewLayout.DirectionEnum) -> CZKit {
        base.direction = direction
        return self
    }
    
    /// 是否固定首列
    @discardableResult
    func isFixedFirstColumn(_ isFixedFirstColumn: Bool) -> CZKit {
        base.isFixedFirstColumn = isFixedFirstColumn
        return self
    }
    
    /// 是否固定首行
    @discardableResult
    func isFixedFirstRow(_ isFixedFirstRow: Bool) -> CZKit {
        base.isFixedFirstRow = isFixedFirstRow
        return self
    }
}
