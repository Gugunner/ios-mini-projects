//
//  FeedDatagram.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 20/04/25.
//

struct FeedDatagram: Decodable {
    let author: String
    let title: String
    let type: String
    let isoCreatedAt: String
    var message: String?
    var description: String?
    var imagePath: String?

    func copy(
        author: String? = nil,
        title: String? = nil,
        type: String? = nil,
        isoCreatedAt: String? = nil,
        message: String? = nil,
        description: String? = nil,
        imagePath: String? = nil
    ) -> FeedDatagram {
        return FeedDatagram(
            author: author ?? self.author,
            title: title ?? self.title,
            type: type ?? self.type,
            isoCreatedAt: isoCreatedAt ?? self.isoCreatedAt,
            message: message ?? self.message,
            description: description ?? self.description,
            imagePath: imagePath ?? self.imagePath
        )
    }
}
