//
//  CZPaddingLabel.swift
//  letaoshijie
//
//  Created by udream3 on 2020/12/22.
//

public class CZPaddingLabel: UILabel {
    
    /// 控制label内容的padding，默认为UIEdgeInsetsZero
    var contentEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = size
        size = super.sizeThatFits(CGSize(width: size.width - (contentEdgeInsets.left + contentEdgeInsets.right), height: size.height - (contentEdgeInsets.top + contentEdgeInsets.bottom)))
        size.width += contentEdgeInsets.left + contentEdgeInsets.right
        size.height += contentEdgeInsets.top + contentEdgeInsets.bottom
        return size
    }
    
    public override var intrinsicContentSize: CGSize {
        var preferredMaxLayoutWidth = self.preferredMaxLayoutWidth
        if preferredMaxLayoutWidth <= 0 {
            preferredMaxLayoutWidth = CGFloat.greatestFiniteMagnitude
        }
        return sizeThatFits(CGSize(width: preferredMaxLayoutWidth, height: CGFloat.greatestFiniteMagnitude))
    }
    
    public override func drawText(in rect: CGRect) {
        var rect = rect
        rect = rect.inset(by: contentEdgeInsets)
        if numberOfLines == 1 && (lineBreakMode == .byWordWrapping || lineBreakMode == .byCharWrapping) {
            rect = CGRectSetHeight(rect, rect.height + contentEdgeInsets.top * 2)
        }
        super.drawText(in: rect)
    }
    
    private func removeFloatMin(_ floatValue: CGFloat) -> CGFloat {
        return floatValue == CGFloat.leastNormalMagnitude ? 0 : floatValue
    }
    
    private func flatSpecificScale(_ floatValue: CGFloat, _ scale: CGFloat) -> CGFloat {
        var floatValue = floatValue
        var scale = scale
        floatValue = removeFloatMin(floatValue)
        scale = CGFloat(scale == 0 ? UIScreen.main.scale : scale)
        let flattedValue = ceil(floatValue * scale) / scale
        return flattedValue
    }
    
    private func flat(_ floatValue: CGFloat) -> CGFloat {
        return flatSpecificScale(floatValue, 0)
    }
    
    private func CGRectSetHeight(_ rect: CGRect, _ height: CGFloat) -> CGRect {
        var rect = rect
        if height < 0 {
            return rect
        }
        rect.size.height = flat(height)
        return rect
    }
    
}

public extension CZKit where Base: CZPaddingLabel {
    
    /// 设置文本内边距
    func contentEdgeInsets(_ contentEdgeInsets: UIEdgeInsets) -> CZKit {
        base.contentEdgeInsets = contentEdgeInsets
        return self
    }
    
    /// 设置文本内边距
    func contentEdgeInsets(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> CZKit {
        base.contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
}
