//
//  CacheManager.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import Foundation

protocol CacheManagerProtocol {
    func cacheObject<T: Encodable>(object: T, key: CacheManagerKey)
    func retrieveCachedObject<T: Decodable>(object: T.Type, key: CacheManagerKey) -> T?
    func removeObject(key: CacheManagerKey)
}

class CacheManager: CacheManagerProtocol {
    static let shared = CacheManager()
    private static let userDefaults = UserDefaults.standard
    private init() {}
    
    func cacheObject<T: Encodable>(object: T, key: CacheManagerKey) {
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(object)
        
        Self.userDefaults.set(data, forKey: key.rawValue)
    }
    
    func retrieveCachedObject<T: Decodable>(object: T.Type, key: CacheManagerKey) -> T? {
        guard let data = CacheManager.userDefaults.data(forKey: key.rawValue) else {
            return nil
        }
        let jsonDecoder = JSONDecoder()
        let object = try? jsonDecoder.decode(T.self, from: data)
        return object
    }
    
    func removeObject(key: CacheManagerKey) {
        Self.userDefaults.removeObject(forKey: key.rawValue)
    }
}

enum CacheManagerKey: String {
    case listItems
    
}
