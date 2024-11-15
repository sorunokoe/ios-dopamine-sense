//
//  File.swift
//  DopamineInfo
//
//  Created by SALGARA, YESKENDIR on 14.11.24.
//

import Foundation

final actor DataSource: DataSourceProtocol {
    private let senseInfoService: ServiceInfoServiceProtocol
    private let persistence: SensePersistenceProtocol

    // YS: Could be extracted, but for now needed like that.
    var questions: [String] = [
        "As an experienced doctor and health influencer, explain in simple terms what dopamine is, its role in the body, and why tracking it could be valuable for mood and behavior insights.",
    ]

    private var answers: [String] = []

    init(senseInfoService: ServiceInfoServiceProtocol, persistence: SensePersistenceProtocol) {
        self.senseInfoService = senseInfoService
        self.persistence = persistence
    }

    func getSummary() async throws -> [String] {
        self.answers = []
        let persistentAnswers = try await loadFromPersistence()
        guard persistentAnswers.isEmpty else {
            return persistentAnswers
        }
        try await withThrowingTaskGroup(of: String.self) { group in
            for question in questions {
                group.addTask {
                    let answer = try await self.senseInfoService.ask(question: question)
                    return answer
                }
            }
            while let result = await group.nextResult() {
                switch result {
                case .failure(let error):
                    throw error
                case .success(let info):
                    answers.append(info)
                }
            }
        }
        return answers
    }

    private func loadFromPersistence() async throws -> [String] {
        let task = Task<[String], Error> {
            try await persistence.load(key: PersistanceKey.answers.rawValue) ?? []
        }
        return try await task.value
    }
    
    func saveToPersistence() async throws {
        let task = Task {
            try await persistence.save(data: answers, by: PersistanceKey.answers.rawValue)
        }
        _ = try await task.value
    }
}

private extension DataSource {
    enum PersistanceKey: String {
        case answers
    }
}
