//
//  File.swift
//  DopamineInfo
//
//  Created by SALGARA, YESKENDIR on 15.11.24.
//

import Foundation

protocol SensePersistenceProtocol: Sendable {
    func load<SenseData>(key: String) async throws -> SenseData? where SenseData: Decodable, SenseData: Sendable
    func save<SenseData>(data: SenseData, by key: String) async throws where SenseData: Encodable, SenseData: Sendable
    func clean(key: String) async throws
}
