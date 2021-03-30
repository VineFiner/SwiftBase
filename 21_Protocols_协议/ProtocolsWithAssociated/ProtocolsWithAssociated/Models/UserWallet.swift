
//
//  UserWallet.swift
//  ProtocolsWithAssociated
//
//  Created by vine on 2020/4/26.
//  Copyright © 2020 vine. All rights reserved.
//

import Foundation
/// 这里是用户
struct User {
    var name: String
    var address: String
    var username: String
    var password: String
}
/// 这里是钱包
struct Wallet {
    var balance: Float
    var currency: String
}

class UserDataParser: DataParsing {
    typealias ParsedData = User
    
    func parseData(_ data: Data) -> User? {
        // parse data...
        let user = User(name: "", address: "", username: "", password: "")
        return user
    }
}

class WalletDataParser: DataParsing {
    typealias ParsedData = Wallet
    
    func parseData(_ data: Data) -> Wallet? {
        // parse data...
        let wallet = Wallet(balance: 0.0, currency: "")
        return wallet
    }
}
