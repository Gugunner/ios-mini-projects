//
//  ViewProtocol.swift
//  infinity_scroll_feed_sample
//
//  Created by Raul_Alonzo on 12/05/25.
//

protocol ViewDataProtocol {
    var payload: FeedPayload? { get set }
    var loading: Bool { get }
    func loadData(_ data: PayloadProtocol)
}
