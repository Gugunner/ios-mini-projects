//
//  Measurements.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 18/04/25.
//

import UIKit

struct Spacing {
    static let xs: CGFloat = 4
    static let s: CGFloat = 8
    static let m: CGFloat = 12
    static let l: CGFloat = 16
    static let xl: CGFloat = 20

    static func by(factor: Int, base: CGFloat?) -> CGFloat {
        return CGFloat(factor) * (base ?? xs)
    }
}
