//
//  MockSenseInfoService.swift
//  DopamineInfo
//
//  Created by SALGARA, YESKENDIR on 15.11.24.
//

@testable import DopamineInfo
import Foundation

final actor MockSenseInfoService: ServiceInfoServiceProtocol {
    enum MockSenseInfoService: Error {
        case noAnswer
    }
    
    private var answer: String?
    
    func ask(question: String) async throws -> String {
        if let answer {
            return answer
        }
        throw MockSenseInfoService.noAnswer
    }
    
    func add(answer: String) {
        self.answer = answer
    }
}
