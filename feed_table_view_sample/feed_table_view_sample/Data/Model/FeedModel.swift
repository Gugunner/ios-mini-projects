//
//  Feed.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

import Foundation

enum FeedType: String, Codable {
    case text
    case post
    case unknown
}

protocol FeedProtocol {
    var identifier: UUID { get }
    var author: String { get set }
    var title: String { get set }
    var createdAt: Date { get set }
    var type: FeedType { get set }
}

class FeedModel: FeedProtocol, DataContextIdModel {
    static var modelKey: DataModelCodingKey = DataModelCodingKey.Feeds

    var identifier: UUID
    var author: String
    var title: String
    var createdAt: Date
    var isoCreatedAt: String
    var type: FeedType

    init(identifier: UUID, author: String, title: String, type: String, isoCreatedAt: String) {
        self.identifier = identifier
        self.author = author
        self.title = title
        //Text is the default value used if type is not a valid enum case
        self.type = FeedType(rawValue: type) ?? FeedType.text
        self.isoCreatedAt = isoCreatedAt
        self.createdAt = ISO8601DateFormatter().date(from: isoCreatedAt) ?? Date()
    }

    init() {
        self.identifier = UUID()
        self.author = "Unknown"
        self.title = "No title"
        self.type = FeedType.unknown
        let date = Date()
        self.isoCreatedAt = ISO8601DateFormatter().string(from: date)
        self.createdAt = date
    }

    //Decodes the model
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: FeedModelCodingKey.self)
        author = try values.decode(String.self, forKey: .author)
        title = try values.decode(String.self, forKey: .title)
        type = try values.decode(FeedType.self, forKey: .type)
        isoCreatedAt = try values.decode(String.self, forKey: .isoCreatedAt)
        createdAt = ISO8601DateFormatter().date(from: isoCreatedAt) ?? Date()
        let decodedIdentifier = try values.decode(
            String.self,
            forKey: .identifier
        )
        guard let uuid = UUID(uuidString: decodedIdentifier) else {
            throw FeedableError.unidentifiableFeed
        }
        identifier = uuid
    }

    func encode(to encoder: Encoder) throws {
        throw FeedableError.notEncodable
    }
}

extension FeedModel {

    static func == (lhs: FeedModel, rhs: FeedModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

}
