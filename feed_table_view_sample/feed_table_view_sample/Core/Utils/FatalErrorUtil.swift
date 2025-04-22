//
//  FatalErrorUtil.swift
//  feed_table_view_sample
//
//  Created by Raul_Alonzo on 20/04/25.
//

enum FatalErrorUtil {
    typealias FatalErrorClosure = (String, StaticString, UInt) -> Never

    static var closure = defaultFatalError

    private static let defaultFatalError: FatalErrorClosure = {message, file, line in
        return Swift.fatalError(message, file: file, line: line)
    }

    static func replaceFatalError(closure: @escaping FatalErrorClosure) {
        FatalErrorUtil.closure = closure
    }

    static func restoreFatalError() {
        FatalErrorUtil.closure = defaultFatalError
    }

    static func fatalError(_ message: String, file: StaticString = #file, line: UInt = #line) -> Never {
        FatalErrorUtil.closure(message, file, line)
    }

    static func returnsNever() -> Never {
        while true {}
    }
}
