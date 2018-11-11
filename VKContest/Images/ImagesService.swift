//
//  ImagesService.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class ImagesService {

    private let cache = NSCache<NSURL, UIImage>()
    private let session: URLSession = .shared
    private let completionCallQueue: DispatchQueue = .main

    func loadImage(from url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        if let cachedImage = self.cache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }

        let task = self.session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: url as NSURL)
                self.completionCallQueue.async {
                    completion(image)
                }
            } else {
                self.completionCallQueue.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
