//
//  BottomMenuItemView.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 9/10/2564 BE.
//

import UIKit

protocol BottomMenuItemViewDelegate: class {
    func didTapBottomMenuItem(content: BottomMenuItem)
}

class BottomMenuItemView: BaseNibView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    weak var delegate: BottomMenuItemViewDelegate?
    
    var content: BottomMenuItem?

    override func setupUI() {
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        titleLabel.textColor = UIColor(red: 162/255, green: 165/255, blue: 171/255, alpha: 1.0)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }

    func configure(with content: BottomMenuItem) {
        self.content = content
        
        if let image = UIImage(named: content.imageName) {
            imageView.image = image
        }
        
        titleLabel.text = content.title
        
        if content.isActive {
            
        }
        titleLabel.textColor = content.isActive ? UIColor(red: 0/255, green: 166/255, blue: 230/255, alpha: 1.0) : UIColor(red: 162/255, green: 165/255, blue: 171/255, alpha: 1.0)
    }
    
    @IBAction private func handleTap(_ sender: UITapGestureRecognizer) {
        if let content = self.content {
            delegate?.didTapBottomMenuItem(content: content)
        }
    }
}
