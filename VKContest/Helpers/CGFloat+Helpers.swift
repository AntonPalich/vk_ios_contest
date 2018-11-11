//
//  CGFloat+Helpers.swift
//  VKContest
//
//  Created by Anton Schukin on 10/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

extension Int {
    var kFormatted: String {
        return String(format: self >= 1000 ? "%.1fK" : "%d", (self >= 1000 ? CGFloat(self)/CGFloat(1000) : self))
    }
}
