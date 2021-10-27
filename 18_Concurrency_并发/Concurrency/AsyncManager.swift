//
//  AsyncManager.swift
//  Concurrency
//
//  Created by Finer  Vine on 2021/10/27.
//

import Foundation

class AsyncManager {
    
    static func run() {
        // Task.init(priority: <#T##TaskPriority?#>, operation: <#T##() async -> _#>)
        // Task.init(priority: <#T##TaskPriority?#>, operation: <#T##() async throws -> _#>)
        // 非结构化并发
        let handle = Task.init(priority: nil) {
            let async = AsyncManager()
            await async.demo1()
        }
        print(handle.isCancelled)
    }
    
    func demo1() async {
        let photoNames = await listPhotos(inGallery: "Summer Vacation")
        let sortedNames = photoNames.sorted()
        let name = sortedNames[0]
        let photo = await downloadPhoto(named: name)
        show(photo)
    }
    
    func demo2() async {
        let photoNames = await listPhotos(inGallery: "Summer Vacation")
        let firstPhoto = await downloadPhoto(named: photoNames[0])
        let secondPhoto = await downloadPhoto(named: photoNames[1])
        let thirdPhoto = await downloadPhoto(named: photoNames[2])

        let photos = [firstPhoto, secondPhoto, thirdPhoto]
        show(photos)
    }
    
    func demo3() async {
        let photoNames = await listPhotos(inGallery: "Summer Vacation")
        async let firstPhoto = downloadPhoto(named: photoNames[0])
        async let secondPhoto = downloadPhoto(named: photoNames[1])
        async let thirdPhoto = downloadPhoto(named: photoNames[2])

        let photos = await [firstPhoto, secondPhoto, thirdPhoto]
        show(photos)
    }
    
    func demo4() async {
        await withTaskGroup(of: Data.self, body: { taskGroup in
            let photoNames = await listPhotos(inGallery: "Summer Vacation")
            for name in photoNames {
                taskGroup.addTask {
                    await self.downloadPhoto(named: name)
                }
            }
        })
    }

    /// 获取画廊图片列表
    /// - Parameters:
    ///   - inGallery: 画廊
    ///   - completion: 获取的图片列表
    func listPhotos(inGallery name: String) async -> [String] {
        var photos: [String] = []
        for item in 0 ..< 30 {
            await Task.sleep(2 * 1_000_000_000)  // Two seconds
            photos.append("\(item)")
        }
        return photos
    }
    
    
    /// 下载图片
    /// - Parameters:
    ///   - named: 图片名称
    ///   - completion: 图片数据
    func downloadPhoto(named: String) async -> Data {
        return Data()
    }
    
    /// 显示图片
    /// - Parameter imageData: 图片数据
    func show(_ imageData: Data) {
        print("image: \(imageData.count)")
    }
    
    /// 显示图片
    /// - Parameter imageData: 图片数据
    func show(_ imageDatas: [Data]) {
        print("image: \(imageDatas.count)")
    }
}
