//
//  AccountModel.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 9/10/2564 BE.
//

import Foundation

struct AccountItem {
    var accountId: String
    var accountName: String
    var accountNo: String
    var currentBalance: String
    var availableBalance: String
    var accountType: String
    var accountPriority: String
}

struct AccountMenuItem {
    var title: String
    var imageName: String
}

struct BottomMenuItem {
    var title: String
    var imageName: String
    var type: BottomMenuItemType
    var isActive: Bool
}

enum BottomMenuItemType {
    case home
    case account
    case scan
    case service
    case setting
}

struct TransactionItem {
    var transactionType: TransactionItemType
    var dateTime: String
    var amount: String
    var toAccountBankName: String
    var toAccountNo: String
    var toAccountName: String
}

enum TransactionItemType {
    case payment
    case transferIn
    case transferOut
    case fee
    case loan
    
    var name: String {
        switch self {
        case .payment:
            return "จ่ายค่าสินค้า/บริการ"
        case .transferIn:
            return "เงินโอนเข้า"
        case .transferOut:
            return "โอนเงินออก"
        case .fee:
            return "ค่าอากรแสตมป์"
        case .loan:
            return "เบิกเงินกู้"
        }
    }
}
