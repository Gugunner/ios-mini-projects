//
//  HeaderStackView.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 17/04/25.
//

import UIKit

class HeaderStackView: UIStackView {

    var leadView: UIView? {
        didSet { reconfigureViews() }
    }
    var trailView: UIView? {
        didSet { reconfigureViews() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStack()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureStack()
    }

    func setUpViews(leadView: UIView, trailView: UIView) {
        self.leadView = leadView
        self.trailView = trailView
    }

    private func configureStack() {
        axis = .horizontal
        spacing = 8.0
        distribution = .fill
    }

    private func clearAll() {
        // MARK: - Makes sure that the stack does not duplicate subviews
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }

    private func reconfigureViews() {
        //Prevents configuring until all views are assigned
        guard let lead = leadView, let trail = trailView else { return }
        clearAll()

        // MARK: - Divides the header in lead and trail using all available space
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacer
            .setContentCompressionResistancePriority(
                .defaultLow,
                for: .horizontal
            )
        spacer.translatesAutoresizingMaskIntoConstraints = false

        //Lead View
        lead.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lead.translatesAutoresizingMaskIntoConstraints = false
        if let label = lead as? UILabel {
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
        }

        //Trail View
        trail.setContentHuggingPriority(.defaultLow, for: .horizontal)
        trail.translatesAutoresizingMaskIntoConstraints = false

        //Stack order
        addArrangedSubview(lead)
        addArrangedSubview(spacer)
        addArrangedSubview(trail)
    }
}
