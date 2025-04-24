//
//  DataModel.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 24/04/25.
//

import Foundation

enum DataModelError: Error, Equatable {
    case cannotLoadUrl(_ file: String)
    case cannotLoadData(_ url: String)
    case cannotDecodeData(_ data: String)
}

struct DataModel<T: DataContextIdModel>: Codable {
    var data: [T] = []

    init(withFile file: String) throws {
        data = try Bundle.main.decode(with: file)
    }

    init() {}

    func encode(to encoder: Encoder) throws {
        guard !data.isEmpty else {
            return
        }
        var container = encoder.container(
            keyedBy: DataModelCodingKey.self
        )
        try container.encode(data, forKey: T.modelKey)
    }
}

extension Bundle {
    func decode<T: Decodable>(with file: String) throws -> [T] {
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            throw DataModelError.cannotLoadUrl("Cannot load the url from \(file)")
        }
        guard let jsonData = try? Data(contentsOf: url) else {
            throw DataModelError.cannotLoadData("Cannot load the data from \(url)")
        }
        guard let decodedData = try? JSONDecoder().decode([T].self,from: jsonData) else {
            throw DataModelError.cannotDecodeData("Data could not be decoded")
        }
        return decodedData
    }
}
