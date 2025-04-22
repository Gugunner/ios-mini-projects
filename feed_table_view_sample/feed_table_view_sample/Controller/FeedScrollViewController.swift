//
//  FeedScrollViewController.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 22/04/25.
//

import UIKit

class FeedScrollViewController: UIViewController {

    let scrollView = UIScrollView()
    let containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }

}

extension FeedScrollViewController {
    private func setUpViews() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.addSubview(containerView)

        view.addSubview(scrollView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate(
[
            scrollView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),

            containerView.topAnchor
                .constraint(equalTo: scrollView.topAnchor, constant: Spacing.xl),
            containerView.trailingAnchor
                .constraint(equalTo: scrollView.trailingAnchor, constant: -Spacing.l),
            containerView.bottomAnchor
                .constraint(equalTo: scrollView.bottomAnchor, constant: -Spacing.xl),
            containerView.leadingAnchor
                .constraint(equalTo: scrollView.leadingAnchor, constant: Spacing.l),
            containerView.widthAnchor
                .constraint(
                    equalTo: scrollView.frameLayoutGuide.widthAnchor,
                    constant: -Spacing.by(factor: 2, base: Spacing.l)
                ),
            containerView.heightAnchor
                .constraint(
                    equalTo: scrollView.frameLayoutGuide.heightAnchor,
                    constant: -Spacing.by(factor: 2, base: Spacing.xl)
                )
        ]
)
    }
}
