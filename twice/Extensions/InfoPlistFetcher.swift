//
//  InfoPlistFetcher.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import Foundation

public enum InfoPlistFetcher {
    static subscript(key: InfoPlistFetcherKey) -> String {
        guard let value = Bundle.main.infoDictionary?[key.rawValue] as? String else {
            fatalError("Could not find value for: \(key)")
        }
        return value.replacingOccurrences(of: "\\", with: "")
    }
}

enum InfoPlistFetcherKey: String {
    case baseUrl = "BaseUrl"
}
