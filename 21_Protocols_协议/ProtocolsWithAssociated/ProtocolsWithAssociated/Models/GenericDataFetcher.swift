//
//  GenericDataFetcher.swift
//  ProtocolsWithAssociated
//
//  Created by vine on 2020/4/26.
//  Copyright © 2020 vine. All rights reserved.
//

import Foundation

class GenericDataFetcher<T>: DataFetching {
    var dataParser: AnyDataParsing<T>
    
    init(dataParser: AnyDataParsing<T>) {
        self.dataParser = dataParser
    }
    
    func fetchData(_ request: URLRequest, resultHandler: @escaping (Result<Data, DataError>) -> Void) {
        // ...
    }
    
    func getParsedData(from data: Data) -> T? {
        return dataParser.parseData(data)
    }
}

class GenericUserFetcher: GenericDataFetcher<User> {
    
}

class GenericWalletFetcher: GenericDataFetcher<Wallet> {
    
}
