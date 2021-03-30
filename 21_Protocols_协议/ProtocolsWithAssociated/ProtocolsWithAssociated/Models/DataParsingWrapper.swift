//
//  DataParsingWrapper.swift
//  ProtocolsWithAssociated
//
//  Created by vine on 2020/4/28.
//  Copyright © 2020 vine. All rights reserved.
//

import Foundation

class AnyDataParsing<T>: DataParsing {
    private let _parseData: (Data) -> T?
    
    init<U: DataParsing>(_ dataParsing: U) where U.ParsedData == T {
        _parseData = dataParsing.parseData
    }
    
    func parseData(_ data: Data) -> T? {
        return _parseData(data)
    }
}
