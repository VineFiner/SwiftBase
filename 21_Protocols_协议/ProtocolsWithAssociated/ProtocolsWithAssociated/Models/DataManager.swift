//
//  DataManager.swift
//  ProtocolsWithAssociated
//
//  Created by vine on 2020/4/26.
//  Copyright © 2020 vine. All rights reserved.
//

import Foundation

class DataManager {
    func fetchUser() {
        let userDataParser = AnyDataParsing(UserDataParser())
        let userFetcher = GenericUserFetcher(dataParser: userDataParser)
        // create URL request...
        let request = URLRequest(url: URL(string: "https://www.baidu.com")!)
        
        userFetcher.fetchData(request) { (result) in
            switch result {
            case .success(let data):
                let user = userFetcher.getParsedData(from: data)
                print(user!)
            case .failure(let error):
                // handle error...
                print(error)
            }
        }
    }
    
    func fetchWallet() {
        let walletDataParser = AnyDataParsing(WalletDataParser())
        let walletFetcher = GenericWalletFetcher(dataParser: walletDataParser)
        
        // create URL request...
        let request = URLRequest(url: URL(string: "https://www.baidu.com")!)

        walletFetcher.fetchData(request) { (result) in
            switch result {
            case .success(let data):
                let wallet = walletFetcher.getParsedData(from: data)
                print(wallet!)
            case .failure(let error):
                // handle error...
                print(error)
            }
        }
    }
}
