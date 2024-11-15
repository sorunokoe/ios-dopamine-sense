//
//  File.swift
//  DopamineInfo
//
//  Created by SALGARA, YESKENDIR on 15.11.24.
//

import Foundation
@testable import DopamineInfo

final actor MockPersistence: SensePersistenceProtocol {
    var isLoaded: Bool = false
    var isSaved: Bool = false
    var isCleaned: Bool = false
    
    func load<SenseData>(key: String) async throws -> SenseData? where SenseData : Decodable, SenseData : Sendable {
        isLoaded = true
        return nil
    }
    
    func save<SenseData>(data: SenseData, by key: String) async throws where SenseData : Encodable, SenseData : Sendable {
        isSaved = true
    }
    
    func clean(key: String) async throws {
        isCleaned = true
    }
    
    func isDataLoaded() async -> Bool {
        isLoaded
    }
}
