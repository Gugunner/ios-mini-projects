//
//  FeedRepository.swift
//  infinity_scroll_feed_sample
//
//  Created by Raul_Alonzo on 12/05/25.
//

import Foundation

class FeedRepository: RepositoryProtocol {
    func loadData(
        page: Int,
        onComplete completionHandler: @escaping (any PayloadProtocol) -> Void,
        onError errorHandler: @escaping () -> Void
    ) {
        let totalPages = 5
        Task {
            if page <= totalPages {
                try await Task.sleep(nanoseconds: 2_000_000_000)
                print("Creating feed for page \(page)")
                let messages = (1...20).map { ("Feed \($0)","Page \(page)") }
                let payload = FeedPayload(
                    page: page,
                    totalPages: totalPages,
                    messages: messages
                )
                DispatchQueue.main.async {
                    completionHandler(payload)
                }
            }
        }
    }
}



