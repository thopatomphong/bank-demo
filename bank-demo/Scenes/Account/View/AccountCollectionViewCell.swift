//
//  AccountCollectionViewCell.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 8/10/2564 BE.
//

import UIKit

protocol AccountCollectionViewCellDelegate: class {
    func didTapAccountItem(content: AccountItem)
}

class AccountCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountNoLabel: UILabel!
    @IBOutlet weak var currentBalanceTitleLabel: UILabel!
    @IBOutlet weak var currentBalanceLabel: UILabel!
    @IBOutlet weak var availableBalanceTitleLabel: UILabel!
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var accountPriorityLabel: UILabel!
    @IBOutlet weak var availableBalanceLabel: UILabel!

    weak var delegate: AccountCollectionViewCellDelegate?
    
    var content: AccountItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }

    func setupUI() {
        containerView.backgroundColor = UIColor(red: 0/255, green: 166/255, blue: 230/255, alpha: 1.0)
        containerView.layer.cornerRadius = 16
        
        accountNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        accountNoLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        currentBalanceTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        currentBalanceLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        availableBalanceTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        accountTypeLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        accountPriorityLabel.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        availableBalanceLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        accountNameLabel.textColor = UIColor.white
        accountNoLabel.textColor = UIColor.white
        currentBalanceTitleLabel.textColor = UIColor.white
        currentBalanceLabel.textColor = UIColor.white
        availableBalanceTitleLabel.textColor = UIColor.white
        accountTypeLabel.textColor = UIColor.white
        accountPriorityLabel.textColor = UIColor.white
        availableBalanceLabel.textColor = UIColor.white
        
        setupShadow()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }
    
    func setupShadow() {
        let shadowHeight: CGFloat = 40
        let shadowWidth: CGFloat = containerView.bounds.width * 0.6
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.1
        let contactRect = CGRect(x: (containerView.bounds.width / 2) - (shadowWidth / 2), y: containerView.bounds.height - (shadowHeight * 0.75), width: shadowWidth, height: shadowHeight)
        containerView.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
    }
    
    func configure(with content: AccountItem) {
        self.content = content
        accountNameLabel.text = content.accountName
        accountNoLabel.text = content.accountNo
        currentBalanceTitleLabel.text = "ยอดเงินคงเหลือ (บาท)"
        currentBalanceLabel.text = content.currentBalance
        availableBalanceTitleLabel.text = "ยอดเงินที่ใช้ได้ (บาท)"
        accountTypeLabel.text = content.accountType
        accountPriorityLabel.text = content.accountPriority
        availableBalanceLabel.text = content.availableBalance
    }
    
    @IBAction private func handleTap(_ sender: UITapGestureRecognizer) {
        if let content = self.content {
            delegate?.didTapAccountItem(content: content)
        }
    }
}
