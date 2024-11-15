//
//  File.swift
//  DopamineInfo
//
//  Created by SALGARA, YESKENDIR on 14.11.24.
//

import Foundation

protocol DataSourceProtocol: Sendable {
    func getSummary() async throws -> [String]
    func saveToPersistence() async throws
}
