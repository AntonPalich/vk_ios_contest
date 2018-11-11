//
//  LoadingIndicatorCell.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import UIKit

class LoadingIndicatorCell: UITableViewCell {

    private let loadingIndicator = UIActivityIndicatorView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .newsBackgroundColor
        self.contentView.addSubview(self.loadingIndicator)
        self.loadingIndicator.color = .black
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.loadingIndicator.sizeToFit()
        self.loadingIndicator.center = self.contentView.center
    }

    func startAnimating() {
        self.loadingIndicator.startAnimating()
    }
}
