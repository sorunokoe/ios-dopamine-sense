//
//  File.swift
//  DopamineInfo
//
//  Created by SALGARA, YESKENDIR on 15.11.24.
//

import Foundation

protocol ServiceInfoServiceProtocol: Sendable {
    func ask(question: String) async throws -> String
}
