//
//  AccountMenuView.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 9/10/2564 BE.
//

import UIKit

protocol AccountMenuViewDelegate: class {
    func didTapAccountMenuItem(content: AccountMenuItem)
}

class AccountMenuView: BaseNibView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    weak var delegate: AccountMenuViewDelegate?
    
    var content: AccountMenuItem?

    override func setupUI() {
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        titleLabel.textColor = UIColor.black
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }

    func configure(with content: AccountMenuItem) {
        self.content = content
        
        if let image = UIImage(named: content.imageName) {
            imageView.image = image
        }
        
        titleLabel.text = content.title
    }
    
    @IBAction private func handleTap(_ sender: UITapGestureRecognizer) {
        if let content = self.content {
            delegate?.didTapAccountMenuItem(content: content)
        }
    }
}
