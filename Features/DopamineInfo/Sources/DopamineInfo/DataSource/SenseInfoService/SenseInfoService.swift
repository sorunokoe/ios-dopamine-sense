//
//  File.swift
//  DopamineInfo
//
//  Created by SALGARA, YESKENDIR on 15.11.24.
//

import Foundation

// YS: Move to SPM package as a Core functionality
final class CacheEntryObject {
    let entry: CacheEntry
    init(entry: CacheEntry) { self.entry = entry }
}

enum CacheEntry {
    case inProgress(Task<String, Error>)
    case ready(String)
}

final actor SenseInfoService: ServiceInfoServiceProtocol {
    private let llmModel: LLMModel
    private let cache: NSCache<NSString, CacheEntryObject> = NSCache()

    private var answers: [String] = []

    init(llmModel: LLMModel) {
        self.llmModel = llmModel
    }

    func ask(question: String) async throws -> String {
        if let cached = cache[question] {
            switch cached {
            case .ready(let info):
                return info
            case .inProgress(let task):
                return try await task.value
            }
        }
        let task = Task<String, Error> {
            switch await llmModel.ask(question: question) {
            case .success(let info):
                return info
            case .failure(let error):
                throw error
            }
        }
        cache[question] = .inProgress(task)
        do {
            let info = try await task.value
            cache[question] = .ready(info)
            return info
        } catch {
            cache[question] = nil
            throw error
        }
    }
}

extension NSCache where KeyType == NSString, ObjectType == CacheEntryObject {
    subscript(_ question: String) -> CacheEntry? {
        get {
            let key = question as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set {
            let key = question as NSString
            if let entry = newValue {
                let value = CacheEntryObject(entry: entry)
                setObject(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
