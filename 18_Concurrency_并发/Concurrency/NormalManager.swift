//
//  NormalManager.swift
//  Concurrency
//
//  Created by Finer  Vine on 2021/10/27.
//

import Foundation

class NormalManager {
    
    static func run() {
        let normal = NormalManager()
        normal.demo1()
    }
    
    func demo1() {
        listPhotos(inGallery: "Summer Vacation") { photoNames in
            let sortedNames = photoNames.sorted()
            let name = sortedNames[0]
            downloadPhoto(named: name) { photo in
                show(photo)
            }
        }
    }
    
    
    /// 获取画廊图片列表
    /// - Parameters:
    ///   - inGallery: 画廊
    ///   - completion: 获取的图片列表
    func listPhotos(inGallery name: String, completion: ([String]) -> ()) {
        var photos: [String] = []
        for item in 0 ..< 30 {
            photos.append("\(item)")
        }
        completion(photos)
    }
    
    
    /// 下载图片
    /// - Parameters:
    ///   - named: 图片名称
    ///   - completion: 图片数据
    func downloadPhoto(named: String, completion: (Data) -> ()) {
        guard let url = URL(string: named) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, res, error in
            
        }.resume()
    }
    
    /// 显示图片
    /// - Parameter imageData: 图片数据
    func show(_ imageData: Data) {
        print("image: \(imageData.count)")
    }
}
