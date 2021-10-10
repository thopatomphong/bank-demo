//
//  BottomMenuView.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 9/10/2564 BE.
//

import UIKit

protocol BottomMenuViewDelegate: class {
    func didTapBottomMenuItem(content: BottomMenuItem)
    func didTapBottomMenuItemScan()
}

class BottomMenuView: BaseNibView {
    
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var bottomView: UIStackView!

    weak var delegate: BottomMenuViewDelegate?
    
    var content: BottomMenuItem?

    override func setupUI() {
        bottomContainerView.layer.cornerRadius = 16
        bottomContainerView.layer.shadowColor = UIColor.gray.cgColor
        bottomContainerView.layer.shadowOffset = CGSize(width: 0, height: -1)
        bottomContainerView.layer.shadowOpacity = 0.25
        bottomContainerView.layer.shadowRadius = 2
        bottomContainerView.layer.masksToBounds =  false
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }
    
    func configure(with content: [BottomMenuItem]) {
        content.forEach { (bottomMenuItem) in
            if bottomMenuItem.type == .scan {
                let menuItemView = BottomMenuItemScanView()
                menuItemView.delegate = self
                bottomView.addArrangedSubview(menuItemView)
            } else {
                let menuItemView = BottomMenuItemView()
                menuItemView.configure(with: bottomMenuItem)
                menuItemView.delegate = self
                bottomView.addArrangedSubview(menuItemView)
            }
        }
    }
    
    @IBAction private func handleTap(_ sender: UITapGestureRecognizer) {
        if let content = self.content {
            delegate?.didTapBottomMenuItem(content: content)
        }
    }
}

extension BottomMenuView: BottomMenuItemViewDelegate {
    func didTapBottomMenuItem(content: BottomMenuItem) {
        delegate?.didTapBottomMenuItem(content: content)
    }
}

extension BottomMenuView: BottomMenuItemScanViewDelegate {
    func didTapBottomMenuItemScan() {
        delegate?.didTapBottomMenuItemScan()
    }
}
