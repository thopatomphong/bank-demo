//
//  AccountMenuTableViewCell.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 9/10/2564 BE.
//

import UIKit

protocol AccountMenuTableViewCellDelegate: class {
    func didTapAccountMenuItem(content: AccountMenuItem)
}

class AccountMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var menuView: UIStackView!
    
    weak var delegate: AccountMenuTableViewCellDelegate?
    
    var accountMenuItemList =  [AccountMenuItem]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        backgroundColor = UIColor.clear
        menuContainerView.layer.cornerRadius = 16
        menuView.layer.cornerRadius = 16
        selectionStyle = .none
    }
    
    func configure(with content: [AccountMenuItem]) {
        if accountMenuItemList.isEmpty {
            accountMenuItemList = content
            content.forEach { (accountMenu) in
                let menuItemView = AccountMenuView()
                menuItemView.configure(with: accountMenu)
                menuItemView.delegate = self
                menuView.addArrangedSubview(menuItemView)
            }
        }
    }
}

extension AccountMenuTableViewCell: AccountMenuViewDelegate {
    func didTapAccountMenuItem(content: AccountMenuItem) {
        delegate?.didTapAccountMenuItem(content: content)
    }
}
