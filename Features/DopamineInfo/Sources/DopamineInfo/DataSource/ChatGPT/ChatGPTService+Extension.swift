//
//  File.swift
//  DopamineInfo
//
//  Created by SALGARA, YESKENDIR on 14.11.24.
//

import Foundation
import ChatGPTService

extension ChatGPTService: LLMModel {
    func ask(question: String) async -> Result<String, Error> {
        await chat(promt: question)
    }
}
