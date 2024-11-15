//
//  File.swift
//  DopamineInfo
//
//  Created by SALGARA, YESKENDIR on 14.11.24.
//

import Foundation

protocol LLMModel: Sendable {
    func ask(question: String) async -> Result<String, Error>
}
