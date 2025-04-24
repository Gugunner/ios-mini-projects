//
//  CodableIdModel.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 24/04/25.
//

import Foundation

protocol CodableIdModel: Codable {
    var identifier: UUID { get }
    static var modelKey: DataModelCodingKey {get}
}

typealias DataContextIdModel = CodableIdModel & Hashable
