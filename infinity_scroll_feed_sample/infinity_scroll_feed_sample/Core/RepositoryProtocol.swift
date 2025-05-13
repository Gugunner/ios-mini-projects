//
//  RepositoryProtocol.swift
//  infinity_scroll_feed_sample
//
//  Created by Raul_Alonzo on 12/05/25.
//

protocol RepositoryProtocol {
    func loadData(
        page: Int,
        onComplete completionHandler: @escaping (
            PayloadProtocol
        ) -> Void,
        onError errorHandler: @escaping () -> Void
    )
}
