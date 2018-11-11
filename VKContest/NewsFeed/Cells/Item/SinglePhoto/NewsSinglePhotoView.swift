//
//  NewsSinglePhotoView.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class NewsSinglePhotoView: UIImageView {

    private var photoImageObserver: AnyObject?

    var viewModel: NewsSinglePhotoViewModel? {
        didSet {
            if let viewModel = self.viewModel {
                self.image = viewModel.photoImage.value
                self.photoImageObserver = viewModel.photoImage.observe { [weak self] (_, new) in
                    self?.image = new
                }
            } else {
                self.image = nil
                self.photoImageObserver = nil
            }
        }
    }
}
