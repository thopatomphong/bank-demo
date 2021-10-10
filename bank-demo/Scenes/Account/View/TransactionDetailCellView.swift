//
//  TransactionDetailCellView.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 9/10/2564 BE.
//

import UIKit

class TransactionDetailCellView: BaseNibView {
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var seperatedlineView: UIView!
    @IBOutlet weak var toBankNameTitleLabel: UILabel!
    @IBOutlet weak var toBankNameLabel: UILabel!
    @IBOutlet weak var accountNoLabel: UILabel!
    @IBOutlet weak var accountNameTitleLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    
    var isLastCell = false
    var isShowDetail = false
    
    override func setupUI() {
        toBankNameTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        toBankNameLabel.font = UIFont.systemFont(ofSize: 14)
        accountNoLabel.font = UIFont.systemFont(ofSize: 14)
        accountNameTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        accountNameLabel.font = UIFont.systemFont(ofSize: 14)
        
        toBankNameTitleLabel.textColor = UIColor.darkGray
        toBankNameLabel.textColor = UIColor.black
        accountNoLabel.textColor = UIColor.black
        accountNameTitleLabel.textColor = UIColor.darkGray
        accountNameLabel.textColor = UIColor.black
        
        backgroundColor = UIColor(red: 250/255, green: 251/255, blue: 254/255, alpha: 1.0)
        layer.masksToBounds = true
        setupRoundCorner()
        showSeperatedLine(isShow: true)
    }

    func configure(with content: TransactionItem, isLastCell: Bool) {
        self.isLastCell = isLastCell
        toBankNameTitleLabel.text = "ไปยังเลขที่บัญชี"
        toBankNameLabel.text = content.toAccountBankName
        accountNoLabel.text = content.toAccountNo
        accountNameTitleLabel.text = "ชื่อบัญชี"
        accountNameLabel.text = content.toAccountName
    }
    
    func setupRoundCorner() {
        layer.cornerRadius = self.isLastCell ? 16 : 0
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func showSeperatedLine(isShow: Bool) {
        if self.isLastCell {
            seperatedlineView.isHidden = true
        } else {
            seperatedlineView.isHidden = !isShow
        }
    }
}
