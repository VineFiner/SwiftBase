//
//  DataParsing.swift
//  ProtocolsWithAssociated
//
//  Created by vine on 2020/4/26.
//  Copyright © 2020 vine. All rights reserved.
//

import Foundation

protocol DataParsing {
    /// 这里是关联类型
    associatedtype ParsedData
    func parseData(_ data: Data) -> ParsedData?
}
