//
//  DataFetching.swift
//  ProtocolsWithAssociated
//
//  Created by vine on 2020/4/26.
//  Copyright © 2020 vine. All rights reserved.
//

import Foundation

enum DataError: Error {
    case fetchError
}

protocol DataFetching {
    func fetchData(_ urlRequest: URLRequest, resultHandler: @escaping (Result<Data, DataError>) -> Void) -> Void
}
