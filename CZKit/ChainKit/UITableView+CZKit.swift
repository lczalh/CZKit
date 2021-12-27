//
//  UITableView+CZKit.swift
//  letaoshijie
//
//  Created by chaozheng on 2019/9/20.
//

import Foundation
import UIKit

public extension CZKit where Base: UITableView {
    
    @discardableResult
    func backgroundView(_ backgroundView: UIView?) -> CZKit {
        base.backgroundView = backgroundView
        return self
    }

    @discardableResult
    func dataSource(_ dataSource: UITableViewDataSource?) -> CZKit {
        base.dataSource = dataSource
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UITableViewDelegate?) -> CZKit {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func rowHeight(_ rowHeight: CGFloat) -> CZKit {
        base.rowHeight = rowHeight
        return self
    }
    
    @discardableResult
    func sectionHeaderHeight(_ sectionHeaderHeight: CGFloat) -> CZKit {
        base.sectionHeaderHeight = sectionHeaderHeight
        return self
    }
    
    @discardableResult
    func sectionFooterHeight(_ sectionFooterHeight: CGFloat) -> CZKit {
        base.sectionFooterHeight = sectionFooterHeight
        return self
    }
    
    @discardableResult
    func estimatedRowHeight(_ estimatedRowHeight: CGFloat) -> CZKit {
        base.estimatedRowHeight = estimatedRowHeight
        return self
    }
    
    @discardableResult
    func estimatedSectionHeaderHeight(_ estimatedSectionHeaderHeight: CGFloat) -> CZKit {
        base.estimatedSectionHeaderHeight = estimatedSectionHeaderHeight
        return self
    }
    
    @discardableResult
    func estimatedSectionFooterHeight(_ estimatedSectionFooterHeight: CGFloat) -> CZKit {
        base.estimatedSectionFooterHeight = estimatedSectionFooterHeight
        return self
    }
    
    @discardableResult
    func sectionIndexColor(_ sectionIndexColor: UIColor?) -> CZKit {
        base.sectionIndexColor = sectionIndexColor
        return self
    }
    
    @discardableResult
    func sectionIndexBackgroundColor(_ sectionIndexBackgroundColor: UIColor?) -> CZKit {
        base.sectionIndexBackgroundColor = sectionIndexBackgroundColor
        return self
    }
    
    @discardableResult
    func sectionIndexTrackingBackgroundColor(_ sectionIndexTrackingBackgroundColor: UIColor?) -> CZKit {
        base.sectionIndexTrackingBackgroundColor = sectionIndexTrackingBackgroundColor
        return self
    }
    
    @discardableResult
    func sectionIndexMinimumDisplayRowCount(_ sectionIndexMinimumDisplayRowCount: Int) -> CZKit {
        base.sectionIndexMinimumDisplayRowCount = sectionIndexMinimumDisplayRowCount
        return self
    }
    
    @discardableResult
    func separatorStyle(_ separatorStyle: UITableViewCell.SeparatorStyle) -> CZKit {
        base.separatorStyle = separatorStyle
        return self
    }

    @discardableResult
    func separatorColor(_ separatorColor: UIColor?) -> CZKit {
        base.separatorColor = separatorColor
        return self
    }
    
    @discardableResult
    func separatorInset(_ separatorInset: UIEdgeInsets) -> CZKit {
        base.separatorInset = separatorInset
        return self
    }
    
    @discardableResult
    func separatorInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> CZKit {
        base.separatorInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func tableHeaderView(_ tableHeaderView: UIView?) -> CZKit {
        base.tableHeaderView = tableHeaderView
        return self
    }
    
    @discardableResult
    func tableFooterView(_ tableFooterView: UIView?) -> CZKit {
        base.tableFooterView = tableFooterView
        return self
    }
    
    @discardableResult
    func register(_ cellNib: UINib?, forCellReuseIdentifier: String) -> CZKit {
        base.register(cellNib, forCellReuseIdentifier: forCellReuseIdentifier)
        return self
    }
    
    @discardableResult
    func register(_ cellClass: Swift.AnyClass?, forCellReuseIdentifier: String) -> CZKit {
        base.register(cellClass, forCellReuseIdentifier: forCellReuseIdentifier)
        return self
    }
    
    @discardableResult
    func register(_ headerFooterNib: UINib?, forHeaderFooterViewReuseIdentifier: String) -> CZKit {
        base.register(headerFooterNib, forHeaderFooterViewReuseIdentifier: forHeaderFooterViewReuseIdentifier)
        return self
    }
    
    @discardableResult
    func register(_ headerFooterClass: Swift.AnyClass?, forHeaderFooterViewReuseIdentifier: String) -> CZKit {
        base.register(headerFooterClass, forHeaderFooterViewReuseIdentifier: forHeaderFooterViewReuseIdentifier)
        return self
    }
    
    @discardableResult
    func keyboardDismissMode(_ keyboardDismissMode: UIScrollView.KeyboardDismissMode) -> CZKit {
        base.keyboardDismissMode = keyboardDismissMode
        return self
    }
    
    @discardableResult
    func editing(_ editing: Bool, animated: Bool) -> CZKit {
        base.setEditing(editing, animated: animated)
        return self
    }
}
