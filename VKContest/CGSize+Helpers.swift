//
//  CGSize+Helpers.swift
//  VKContest
//
//  Created by Anton Schukin on 09/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

extension CGSize {
    func inset(by insets: UIEdgeInsets) -> CGSize {
        return CGSize(
            width: self.width - insets.left - insets.right,
            height: self.height - insets.top - insets.bottom
        )
    }
}
