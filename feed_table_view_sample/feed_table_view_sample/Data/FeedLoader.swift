//
//  FeedLoader.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 09/04/25.
//

class FeedLoader: FeedLoaderProtocol {
    let feedModelFields = ["author","title","type","isoCreatedAt"]
    let textFeedModelFields = ["message"]
    let postFeedModelFields = ["imagePath","description"]

    // MARK: - Loads all data and converts it to FeedModel objects
    func loadAllFeeds(data: [[String:String]]) throws -> [FeedModel] {
        if data.isEmpty {
            throw FeedableError.emptyFeeds
        }
        return try data.compactMap({ (datagram) -> FeedModel? in
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
    func loadSingleFeed(_ datagram: [String:String]) throws -> FeedModel? {
        do {
            try checkFeedInDict(datagram)
        } catch FeedableError.missingValues(let values) {
            throw FeedableError.cannotLoadFeed("The feed is missing the following values: \(values)")
        } catch {
            throw FeedableError.cannotLoadFeed("The feed could not be loaded due to error: \(error)")
        }
        switch (datagram["type"]) {
            case FeedType.text.rawValue:
                return loadTextFeed(datagram)
            case FeedType.post.rawValue:
                return loadPostFeed(datagram)
            default:
                return loadUnknowFeed()
        }
    }

    //MARK: - Logic to verify datagram fields

    func checkFeedInDict(_ datagram: [String: String]) throws {
        if datagram.isEmpty {
            throw FeedableError.emptyFeed
        }

        guard let type = datagram["type"] else {
            throw FeedableError.undefinedType
        }

        let requiredKeys: [String] = {
            switch (type) {
                case FeedType.text.rawValue:
                return feedModelFields + textFeedModelFields
            case FeedType.post.rawValue:
                return feedModelFields + postFeedModelFields
            default:
                return feedModelFields
            }
        }()

        let errors = requiredKeys.filter {
            datagram[$0] == nil || datagram[$0]!.isEmpty
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

    func loadTextFeed(_ textDatagram: [String:String]) -> FeedModel? {
        guard let fields = extractRequiredFields(
            textDatagram,
            keys: feedModelFields
            + textFeedModelFields) else { return nil }
        return TextFeedModel(
            author: fields["author"]!,
            title: fields["title"]!,
            message: fields["message"]!,
            type: fields["type"]!,
            isoCreatedAt: fields["isoCreatedAt"]!
        )
    }

    func loadPostFeed(_ postDatagram: [String:String]) -> FeedModel? {
        guard let fields = extractRequiredFields(
            postDatagram,
            keys: feedModelFields
            + postFeedModelFields) else { return nil }
        return PostFeedModel(
            author: fields["author"]!,
            title: fields["title"]!,
            imagePath: fields["imagePath"]!,
            description: fields["description"]!,
            isoCreatedAt: fields["isoCreatedAt"]!,
            type: fields["type"]!
        )
    }
}
