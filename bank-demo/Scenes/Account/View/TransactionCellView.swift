//
//  TransactionCellView.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 9/10/2564 BE.
//

import UIKit

class TransactionCellView: BaseNibView {
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var seperatedlineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var expandImageView: UIImageView!
    
    var isFirstCell = false
    var isLastCell = false
    var isShowDetail = false
    
    override func setupUI() {
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        datetimeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        amountLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = UIColor.black
        datetimeLabel.textColor = UIColor.lightGray
        amountLabel.textColor = UIColor.black
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupRoundCorner(isFirstCell: self.isFirstCell, isLastCell: self.isLastCell, isShowDetail: self.isShowDetail)
    }

    func configure(with content: TransactionItem, isFirstCell: Bool, isLastCell: Bool) {
        self.isFirstCell = isFirstCell
        self.isLastCell = isLastCell
        
        titleLabel.text = content.transactionType.name
        datetimeLabel.text = content.dateTime
        
        setupAmountLabel(content: content)
        setupRoundCorner(isFirstCell: isFirstCell, isLastCell: isLastCell, isShowDetail: self.isShowDetail)
        showSeperatedLine(isShow: !isLastCell)
    }
    
    private func setupAmountLabel(content: TransactionItem) {
        amountLabel.text = content.amount
        
        var amountLabelColor = UIColor.black
        switch content.transactionType {
        case .loan:
            amountLabelColor = UIColor(red: 0/255, green: 166/255, blue: 230/255, alpha: 1.0)
        case .transferIn:
            amountLabelColor = UIColor(red: 13/255, green: 229/255, blue: 20/255, alpha: 1.0)
        case .fee, .payment, .transferOut:
            amountLabel.text = "-\(content.amount)"
            amountLabelColor = UIColor(red: 229/255, green: 13/255, blue: 13/255, alpha: 1.0)
        }
        
        amountLabel.textColor = amountLabelColor
    }
    
    func showSeperatedLine(isShow: Bool) {
        if self.isLastCell {
            seperatedlineView.isHidden = true
        } else {
            seperatedlineView.isHidden = !isShow
        }
    }
    
    func setupRoundCorner(isFirstCell: Bool, isLastCell: Bool, isShowDetail: Bool) {
        var cornerRadius: CGFloat = 0
        var maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        if isFirstCell {
            maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cornerRadius = 16
        }
        
        if isLastCell {
            maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cornerRadius = 16
        }
        
        if isShowDetail {
            maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cornerRadius = 0
        }
        
        contentContainerView.layer.cornerRadius = cornerRadius
        contentContainerView.layer.maskedCorners = maskedCorners
    }
    
    func setupExpendImage(isShowDetail: Bool) {
        let imageName = isShowDetail ? "icon_arrow_up" : "icon_arrow_down"
        expandImageView.image = UIImage(named: imageName)
    }
}
