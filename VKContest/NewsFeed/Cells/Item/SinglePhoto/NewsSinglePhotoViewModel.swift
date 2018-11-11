//
//  NewsSinglePhotoViewModel.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsSinglePhotoViewModel {

    var photoImage = Observable<UIImage?>(nil)

    private let imagesService: ImagesService
    let photo: PhotoSize

    init(photo: PhotoSize, imagesService: ImagesService) {
        self.photo = photo
        self.imagesService = imagesService
    }

    func onWillDisplay() {
        if let url = URL(string: self.photo.url) {
            self.imagesService.loadImage(from: url) { [weak self] (image) in
                self?.photoImage.value = image
            }
        }
    }
}
