//
//  File.swift
//  DopamineInfo
//
//  Created by SALGARA, YESKENDIR on 14.11.24.
//

@testable import DopamineInfo
import Foundation

final actor MockLLMModel: LLMModel {
    enum MockLLMModelError: Error {
        case noAnswer
    }

    private var answer: String?

    func ask(question: String) async -> Result<String, any Error> {
        if let answer {
            return .success(answer)
        }
        return .failure(MockLLMModelError.noAnswer)
    }
    
    func add(answer: String) {
        self.answer = answer
    }
}
