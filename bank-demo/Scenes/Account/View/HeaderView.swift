//
//  HeaderView.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 9/10/2564 BE.
//

import UIKit

protocol HeaderViewDelegate: class {
    func didTapRightButton()
}

class HeaderView: BaseNibView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!

    weak var delegate: HeaderViewDelegate?
    
    override func setupUI() {
        backgroundColor = UIColor.clear
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = UIColor.black
    }
    
    func configure(title: String, rightButtonImage: String) {
        titleLabel.text = title
        rightButton.setImage(UIImage(named: rightButtonImage), for: .normal)
    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        delegate?.didTapRightButton()
    }
}
