//
//  FeedImageView.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 18/04/25.
//

import UIKit

class FeedImageView: UIView {

    private var aspectConstraint: NSLayoutConstraint?

    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var placeholderImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "questionmark.circle")
        iv.tintColor = .secondaryLabel
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpImages()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpImages()
    }

    private func setUpImages() {
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit

        addSubview(imageView)
        addSubview(placeholderImageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),

            placeholderImageView.topAnchor.constraint(equalTo: topAnchor),
            placeholderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            placeholderImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            placeholderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }

    func configureImageFrom(name named: String) {
        let configuredImage = UIImage(named: named)
        if let image = configuredImage {
            imageView.image = image
            hidePlaceholderImage(true)
            removeAllConstraints(from: imageView)
            let aspectRatio = image.size.height / image.size.width
            configureAspectConstraint(from: aspectRatio)
        } else {
            removeAllConstraints(from: placeholderImageView)
            configureAspectConstraint(from: 1.33333333)
            hidePlaceholderImage(false)
        }
    }

    private func configureAspectConstraint(from aspectRatio: CGFloat) {
        if let oldConstraint = aspectConstraint {
            removeConstraint(oldConstraint)
        }

        let constraint = heightAnchor
            .constraint(equalTo: widthAnchor, multiplier: aspectRatio)
        constraint.isActive = true
        aspectConstraint = constraint
    }

    private func hidePlaceholderImage(_ hide: Bool) {
        placeholderImageView.isHidden = hide
    }

    private func removeAllConstraints(from view: UIView) {
        view.constraints.forEach { $0.isActive = false }
    }
}
