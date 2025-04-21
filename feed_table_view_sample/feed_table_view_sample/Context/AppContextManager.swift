//
//  AppContextManager.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 20/04/25.
//

class AppContextManager {
    static let app = AppContextManager()

    private var context: AppConfigureContext?

    //Makes for the singleton pattern
    private init() {}

    var shared: AppConfigureContext {
        guard let context = AppContextManager.app.context else {
            FatalErrorUtil
                .fatalError("App context must be configured before use.")
        }
       return context
    }

    //Must be called before any app context can be used
    func configure(with context: AppConfigureContext) {
        AppContextManager.app.context = context
    }
}
