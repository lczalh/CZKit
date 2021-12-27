//
//  CZMarginTableViewCell.swift
//  letaoshijie
//
//  Created by chaozheng on 2021/6/16.
//

import UIKit
import SnapKit

public class CZBaseTableViewCell: UITableViewCell {
    
    /// 设置边缘距离
    var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            contentView.snp.remakeConstraints { make in
                make.edges.equalToSuperview().inset(edgeInsets)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.cz.remakeConstraints({ make in
            make.edges.equalToSuperview()
        }).backgroundColor(.white)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
