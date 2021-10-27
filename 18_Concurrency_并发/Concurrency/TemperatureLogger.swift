//
//  TemperatureLogger.swift
//  Concurrency
//
//  Created by Finer  Vine on 2021/10/27.
//

import Foundation

/// 温度记录器
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }

    func demo1() async {
        let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
        print(await logger.max)
    }
}

extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}
