//
//  AccountViewController.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 8/10/2564 BE.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentAccountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomMenuView: BottomMenuView!
    
    var viewModel = AccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 250/255, green: 251/255, blue: 254/255, alpha: 1.0)
        
        setupHeaderView()
        setupCollectionView()
        setupTableView()
        setupBottomMenuView()
        setupCurrentAccount()
    }
    
    private func setupHeaderView() {
        headerView.configure(title: "บัญชีเงินฝาก", rightButtonImage: "icon_menu")
        headerView.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "AccountCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AccountCollectionViewCellRID")
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    private func setupCurrentAccount() {
        currentAccountLabel.text = viewModel.output.accountList.isEmpty ? "" : "1/\(viewModel.output.accountList.count)"
    }
    
    private func setupBottomMenuView() {
        bottomMenuView.configure(with: viewModel.output.bottomMenuList)
        bottomMenuView.delegate = self
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AccountMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountMenuTableViewCellRID")
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "TransactionTableViewCellRID")
        tableView.separatorStyle = .none
        
        let dummyHeaderViewHeight = CGFloat(40)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: dummyHeaderViewHeight))
        tableView.contentInset = UIEdgeInsets(top: -dummyHeaderViewHeight, left: 0, bottom: 0, right: 0)
        
        tableView.layer.masksToBounds = false
        tableView.layer.shadowColor = UIColor.gray.cgColor
        tableView.layer.shadowOpacity = 0.25
        tableView.layer.shadowRadius = 2
        tableView.layer.shadowOffset = .init(width: 1, height: 1) 
    }
    
    private func scrollToNearCell(scrollView: UIScrollView) {
        let middlePoint = Int(scrollView.contentOffset.x + UIScreen.main.bounds.width / 2)
        if let indexPath = collectionView.indexPathForItem(at: CGPoint(x: middlePoint, y: 0)) {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    private func showPopup(_ title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default))
        self.present(alert, animated: true)
    }
}

extension AccountViewController: HeaderViewDelegate {
    func didTapRightButton() {
        showPopup("เมนู")
    }
}

extension AccountViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.accountList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCollectionViewCellRID", for: indexPath) as? AccountCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: viewModel.output.accountList[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension AccountViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let _ = scrollView as? UICollectionView {
            scrollToNearCell(scrollView: scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let _ = scrollView as? UICollectionView {
            scrollToNearCell(scrollView: scrollView)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let _ = scrollView as? UICollectionView {
            let point = CGPoint(x: scrollView.bounds.midX, y: scrollView.bounds.midY)
            guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
            let currentPage = indexPath.item + 1
            currentAccountLabel.text = "\(currentPage)/\(viewModel.output.accountList.count)"
        }
    }
}

extension AccountViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width - 32, height: self.view.bounds.height * 0.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension AccountViewController: AccountCollectionViewCellDelegate {
    func didTapAccountItem(content: AccountItem) {
        showPopup(content.accountName)
    }
}

extension AccountViewController: AccountMenuTableViewCellDelegate {
    func didTapAccountMenuItem(content: AccountMenuItem) {
        showPopup(content.title)
    }
}

extension AccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.output.transactionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountMenuTableViewCellRID", for: indexPath) as? AccountMenuTableViewCell  else {
                return UITableViewCell()
            }
            cell.configure(with: viewModel.output.accountMenuList)
            cell.delegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCellRID", for: indexPath) as? TransactionTableViewCell  else {
                return UITableViewCell()
            }
            
            let isFirstCell = indexPath.row == 0
            let isLastCell = indexPath.row == (viewModel.output.transactionList.count - 1)
            
            cell.configure(with: viewModel.output.transactionList[indexPath.row], isFirstCell: isFirstCell, isLastCell: isLastCell)
            return cell
        }
    }
}

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 8, width: 200, height: 24))
        titleLabel.text = "รายการย้อนหลัง"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let sectionHeaderView =  UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        
        sectionHeaderView.addSubview(titleLabel)
        sectionHeaderView.backgroundColor = UIColor.clear
        
        return section == 1 ? sectionHeaderView : nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView =  UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 72))
        return section == 1 ? footerView : nil
    }
    
    func tableView(_ : UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 40 : 0
    }
    
    func tableView(_ : UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 1 ? 72 : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.performBatchUpdates(nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = self.tableView.cellForRow(at: indexPath) as? TransactionTableViewCell {
            cell.hideDetailView()
        }
    }
}

extension AccountViewController: BottomMenuViewDelegate {
    func didTapBottomMenuItem(content: BottomMenuItem) {
        showPopup(content.title)
    }
    
    func didTapBottomMenuItemScan() {
        showPopup("Scan")
    }
}
