//
//  StorageService.swift
//  Movies
//
//  Created by Piotr Adamczak on 17/02/2021.
//

import Foundation

protocol StorageServiceProtocol {
    var userDefaults: UserDefaults { get }
    var storageKey: String { get }

    func isKeyPresent(_ key: String) -> Bool
    func tooglePresent(for key: String)
    func setPresent(_ present: Bool, for key: String)
}

class FavouriteStorageService: StorageServiceProtocol {
    var userDefaults: UserDefaults = UserDefaults.standard

    var storageKey: String = "favourites"

    func isKeyPresent(_ key: String) -> Bool {
        let allKeys = userDefaults.object(forKey: storageKey) as? [String: Bool] ?? [:]
        return allKeys[key] != nil
    }

    func tooglePresent(for key: String) {
        setPresent(!isKeyPresent(key), for: key)
    }

    func setPresent(_ present: Bool, for key: String) {
        var allKeys = userDefaults.object(forKey: storageKey) as? [String: Bool] ?? [:]
        if present {
            allKeys[key] = true
        } else {
            allKeys[key] = nil
        }
        userDefaults.set(allKeys, forKey: storageKey)
    }
}
