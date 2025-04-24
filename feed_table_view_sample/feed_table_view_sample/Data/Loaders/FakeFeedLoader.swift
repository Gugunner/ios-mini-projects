//
//  FeedLoader.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

import Foundation

class FakeFeedLoader: FeedLoaderProtocol {
    var data: [FeedDatagram]?
    var feeds: [FeedModel]?

    func loadData() async throws {
        let json: [[String: Any]] = dataSample
        let decoder = JSONDecoder()
        let jsonData = try JSONSerialization.data(withJSONObject: json)
        data = try decoder.decode([FeedDatagram].self, from: jsonData)
    }

    // MARK: - Loads all data and converts it to FeedModel objects
    func loadAllFeeds() throws {
        guard let data = self.data else {
            throw FeedableError.cannotLoadFeed("Data has not been loaded")
        }
        if data.isEmpty {
            throw FeedableError.emptyFeeds
        }
        feeds = try data.compactMap({ (datagram) -> FeedModel? in
            do {
                return try loadSingleFeed(datagram)
            } catch FeedableError.cannotLoadFeed(let message) {
                print(message)
            } catch {
                throw error
            }
            return nil
        })
    }

    // MARK: - Given a datagram dictionary convert it to a FeedModel
    func loadSingleFeed(_ datagram: FeedDatagram) throws -> FeedModel? {
        do {
            try checkFeedInDict(datagram)
        } catch FeedableError.missingValues(let values) {
            throw FeedableError.cannotLoadFeed("The feed is missing the following values: \(values)")
        } catch {
            throw FeedableError.cannotLoadFeed("The feed could not be loaded due to error: \(error)")
        }
        switch (datagram.type) {
            case FeedType.text.rawValue:
                return loadTextFeed(datagram)
            case FeedType.post.rawValue:
                return loadPostFeed(datagram)
            default:
                return loadUnknowFeed()
        }
    }

    //MARK: - Logic to verify datagram fields

    func checkFeedInDict(_ datagram: FeedDatagram) throws {
        if datagram.identifier.isEmpty || UUID(uuidString: datagram.identifier) == nil {
            throw FeedableError.unidentifiableFeed
        }

        if datagram.type.isEmpty {
            throw FeedableError.undefinedType
        }

        var errors: [String] = []

        if datagram.author.isEmpty {
            errors.append("author")
        }

        if datagram.title.isEmpty {
            errors.append("title")
        }

        if datagram.isoCreatedAt.isEmpty {
            errors.append("isoCreatedAt")
        }

        if datagram.type == FeedType.text.rawValue {
            if datagram.message == nil || datagram.message!.isEmpty {
                errors.append("message")
            }
        } else if datagram.type == FeedType.post.rawValue {
            if datagram.description == nil || datagram.description!.isEmpty {
                errors.append("description")
            }
            
            if datagram.imagePath == nil || datagram.imagePath!.isEmpty {
                errors.append("imagePath")
            }
        }
        
        if !errors.isEmpty {
            throw FeedableError.missingValues(errors.joined(separator: ", "))
        }
    }

    //MARK: - Build specific FeedModels based on the type

    func extractRequiredFields(_ datagram: [String:String], keys: [String]) -> [String:String]? {
        var result: [String:String] = [:]
        for key in keys {
            guard let value = datagram[key] else { return nil }
            result[key] = value
        }
        return result
    }

    func loadUnknowFeed() -> FeedModel {
        return FeedModel()
    }

    func loadTextFeed(_ textDatagram: FeedDatagram) -> FeedModel? {
        guard let uuid = UUID(uuidString: textDatagram.identifier) else {
            return nil
        }
        return TextFeedModel(
            identifier: uuid,
            author: textDatagram.author,
            title: textDatagram.title,
            message: textDatagram.message ?? "",
            type: textDatagram.type,
            isoCreatedAt: textDatagram.isoCreatedAt
        )
    }

    func loadPostFeed(_ postDatagram: FeedDatagram) -> FeedModel? {
        guard let uuid = UUID(uuidString: postDatagram.identifier) else {
            return nil
        }
        return PostFeedModel(
            identifier: uuid,
            author: postDatagram.author,
            title: postDatagram.title,
            imagePath: postDatagram.imagePath ?? "",
            description: postDatagram.description ?? "",
            isoCreatedAt: postDatagram.isoCreatedAt,
            type: postDatagram.type
        )
    }
}
