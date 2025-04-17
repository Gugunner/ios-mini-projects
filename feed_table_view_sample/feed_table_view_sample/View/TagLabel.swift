//
//  TagLabel.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

import UIKit

class TagLabel: UIView {

    let label = UILabel()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        //Style container
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            //Add paddings to label container
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            label.trailingAnchor
                .constraint(equalTo: self.trailingAnchor, constant: -8),
            label.bottomAnchor
                .constraint(equalTo: self.bottomAnchor, constant: -4),
            label.leadingAnchor
                .constraint(equalTo: self.leadingAnchor, constant: 8),

            self.heightAnchor.constraint(equalToConstant: 36),
        ])
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.numberOfLines = 0
    }
}
