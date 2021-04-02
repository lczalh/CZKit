//
//  CZVerticalAlignmentLabel.swift
//  letaoshijie
//
//  Created by udream3 on 2020/12/24.
//

public enum CZVerticalAlignment {
    case top
    case middle
    case bottom
}

public class CZVerticalAlignmentLabel: UILabel {
    
    /// 设置垂直对齐方式 默认顶部对齐
    var verticalAlignment : CZVerticalAlignment = .middle {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines: Int) -> CGRect {
        let rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: limitedToNumberOfLines)
        
        if UIView.userInterfaceLayoutDirection(for: .unspecified) == .rightToLeft {
            switch verticalAlignment {
            case .top:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
            case .middle:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
            case .bottom:
                return CGRect(x: self.bounds.size.width - rect.size.width, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
            }
        } else {
            switch verticalAlignment {
            case .top:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
            case .middle:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
            case .bottom:
                return CGRect(x: bounds.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
            }
        }
    }
    
    override public func drawText(in rect: CGRect) {
        let rect = textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: rect)
    }
    
}

public extension CZKit where Base: CZVerticalAlignmentLabel {
    
    /// 设置垂直对齐方式
    func verticalAlignment(_ verticalAlignment : CZVerticalAlignment) -> CZKit {
        base.verticalAlignment = verticalAlignment
        return self
    }
}
