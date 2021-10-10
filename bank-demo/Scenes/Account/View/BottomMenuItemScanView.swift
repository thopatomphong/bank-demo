//
//  BottomMenuItemScanView.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 9/10/2564 BE.
//

import UIKit

protocol BottomMenuItemScanViewDelegate: class {
    func didTapBottomMenuItemScan()
}

class BottomMenuItemScanView: BaseNibView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    weak var delegate: BottomMenuItemScanViewDelegate?
    
    var content: BottomMenuItem?

    override func setupUI() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }
    
    @IBAction private func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.didTapBottomMenuItemScan()
    }
}
