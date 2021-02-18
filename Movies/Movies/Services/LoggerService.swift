//
//  LoggerService.swift
//  Movies
//
//  Created by Piotr Adamczak on 16/02/2021.
//

import Foundation
import os.log

struct LoggerService {
    // On iOS 14 we could use built-in Logger
    static var shared = LoggerService()

    func debug(_ log: String) {
        #if DEBUG
        os_log("[Debug] %@", log: .default, type: .debug, log)
        #endif
    }

    func error(_ log: String) {
        #if DEBUG
        os_log("[Error] %@", log: .default, type: .error, log)
        #endif
    }
}
