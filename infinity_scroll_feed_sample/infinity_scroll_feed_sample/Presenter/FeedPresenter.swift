//
//  FeedPresenter.swift
//  infinity_scroll_feed_sample
//
//  Created by Raul_Alonzo on 12/05/25.
//

class FeedPresenter {

    var repository: RepositoryProtocol
    var view: ViewDataProtocol!

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }

    func loadData() {
        print("Loading data from presenter")
        let page = (view.payload?.page ?? 0) + 1
        repository
            .loadData(page: page, onComplete: view.loadData(_:), onError: {
                print("An error occured when loading data")
            })
    }

}
