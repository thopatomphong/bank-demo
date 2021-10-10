//
//  TransactionTableViewCell.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 9/10/2564 BE.
//

import UIKit

final class TransactionTableViewCell: UITableViewCell {
    
    private let containerView = UIStackView()
    private let cellView = TransactionCellView()
    private let detailView = TransactionDetailCellView()
    
    var isDetailViewHidden: Bool {
        return detailView.isHidden
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isDetailViewHidden, selected {
            showDetailView()
        } else {
            hideDetailView()
        }
    }
    
    func showDetailView() {
        cellView.showSeperatedLine(isShow: false)
        cellView.isShowDetail = true
        cellView.setupExpendImage(isShowDetail: true)
        detailView.isHidden = false
        detailView.setupRoundCorner()
    }

    func hideDetailView() {
        cellView.showSeperatedLine(isShow: true)
        cellView.isShowDetail = false
        cellView.setupExpendImage(isShowDetail: false)
        detailView.isHidden = true
        detailView.setupRoundCorner()
        detailView.showSeperatedLine(isShow: true)
    }
    
    func configure(with content: TransactionItem, isFirstCell: Bool, isLastCell: Bool) {
        cellView.configure(with: content, isFirstCell: isFirstCell, isLastCell: isLastCell)
        detailView.configure(with: content, isLastCell: isLastCell)
    }
    
    func commonInit() {
        selectionStyle = .none
        detailView.isHidden = true

        backgroundColor = UIColor.clear
        containerView.axis = .vertical
        containerView.backgroundColor = UIColor.clear

        contentView.addSubview(containerView)
        containerView.addArrangedSubview(cellView)
        containerView.addArrangedSubview(detailView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        cellView.translatesAutoresizingMaskIntoConstraints = false
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
}
