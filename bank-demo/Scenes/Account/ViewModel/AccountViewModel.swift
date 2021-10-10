//
//  AccountViewModel.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 10/10/2564 BE.
//

import Foundation

protocol AccountProtocol {
    var input: AccountProtocolInput { get }
    var output: AccountProtocolOutput { get }
}

protocol AccountProtocolInput: class {
    func fetchAccountItems()
    func fetchAccountTransactionList()
    func fetchAccountMenuList()
    func fetchBottomMenuList()
}

protocol AccountProtocolOutput: class {
    var accountList: [AccountItem] { get }
    var accountMenuList: [AccountMenuItem] { get }
    var bottomMenuList: [BottomMenuItem] { get }
    var transactionList: [TransactionItem] { get }
}

final class AccountViewModel: AccountProtocol {
    var input: AccountProtocolInput { return self }
    var output: AccountProtocolOutput { return self }
    
    init() {}
}

extension AccountViewModel: AccountProtocolInput {
    func fetchAccountItems() {
        
    }
    
    func fetchAccountTransactionList() {
        
    }
    
    func fetchAccountMenuList() {
        
    }
    
    func fetchBottomMenuList() {
        
    }
}

extension AccountViewModel: AccountProtocolOutput {
    var accountList: [AccountItem] {
        [AccountItem(accountId: "1", accountName: "วายุ มีตัง", accountNo: "XXX-X-XX563-9", currentBalance: "20,000.00", availableBalance: "20,000.00", accountType: "ออมทรัพย์", accountPriority: "บัญชีหลัก"),  AccountItem(accountId: "2", accountName: "ร่ำรวย มั่งมี", accountNo: "XXX-X-XX999-9", currentBalance: "9,999,999.99", availableBalance: "9,999,999.99", accountType: "ออมทรัพย์", accountPriority: "บัญชีสำรอง"), AccountItem(accountId: "3", accountName: "ใช้จ่ายส่วนตัว", accountNo: "XXX-X-XX123-4", currentBalance: "12,345.00", availableBalance: "2,000.00", accountType: "ออมทรัพย์", accountPriority: "บัญชีสำรอง"), AccountItem(accountId: "4", accountName: "ลงทุน", accountNo: "XXX-X-XX555-5", currentBalance: "50,000.00", availableBalance: "50,000.00", accountType: "ออมทรัพย์", accountPriority: "บัญชีสำรอง")]
    }
    
    var accountMenuList: [AccountMenuItem] {
        [AccountMenuItem(title: "โอนเงิน", imageName: "icon_transfer"), AccountMenuItem(title: "เติมเงิน", imageName: "icon_topup"), AccountMenuItem(title: "จ่ายบิล", imageName: "icon_paybill"), AccountMenuItem(title: "เมนูอื่นๆ", imageName: "icon_more")]
    }
    
    var bottomMenuList: [BottomMenuItem] {
        [BottomMenuItem(title: "หน้าหลัก", imageName: "icon_home", type: .home,  isActive: false), BottomMenuItem(title: "บัญชี", imageName: "icon_account_active", type: .account, isActive: true), BottomMenuItem(title: "สแกน", imageName: "icon_scan", type: .scan, isActive: false), BottomMenuItem(title: "บริการ", imageName: "icon_service", type: .service, isActive: false), BottomMenuItem(title: "ตั้งค่า", imageName: "icon_setting", type: .setting, isActive: false)]
    }
    
    var transactionList: [TransactionItem] {
        [TransactionItem(transactionType: .loan, dateTime: "10 พ.ค. 2564 - 22:00", amount: "20,000.00", toAccountBankName: "กรุงไทย", toAccountNo: "XXX-X-XX563-9", toAccountName: "วายุ มีตัง"), TransactionItem(transactionType: .fee, dateTime: "10 พ.ค. 2564 - 22:00", amount: "150.00", toAccountBankName: "กรุงไทย", toAccountNo: "XXX-X-XX563-9", toAccountName: "วายุ มีตัง")]
    }
}
