//
//  ThreadUtil.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 20/04/25.
//

import Foundation

enum ThreadUtil {
    static func assertNotOnMainThread() {
        if Thread.isMainThread {
            Swift.fatalError("Cannot execute on main thread")
        }
    }
}
