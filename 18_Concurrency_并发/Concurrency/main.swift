//
//  main.swift
//  Concurrency
//
//  Created by Finer  Vine on 2021/9/21.
//

import Foundation

NormalManager.run()

AsyncManager.run()

// 非结构化并发
Task {
    let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
    await logger.demo1()
    await print(logger.max)
}
print("Hello, World!")
