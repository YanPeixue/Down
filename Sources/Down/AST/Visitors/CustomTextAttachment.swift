//
//  CustomTextAttachment.swift
//  JuicyChat
//
//  Created by yanpeixue on 2024/11/5.
//

import UIKit

open class CustomTextAttachment: NSTextAttachment {
    var imageURL: URL? // 存储图片的 URL
    
    // 自定义初始化方法
    public init(image: UIImage?, imageURL: URL?) {
        super.init(data: nil, ofType: nil)
        self.image = image
        self.imageURL = imageURL
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // 异步加载图片的方法
    public func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = imageURL else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            
            guard let data = data,
                  error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }

        }.resume()
    }

    // 更新图像的方法
    func updateImage(with image: UIImage) {
        self.image = image
        self.bounds = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        self.contents = image.pngData() // 更新 contents
    }
}
