//
//  File.swift
//  DopamineInfo
//
//  Created by SALGARA, YESKENDIR on 15.11.24.
//

import os
import SwiftUI

public final actor DopamineInfoModel: ObservableObject {
    let dataSource: DataSourceProtocol

    @MainActor @Published var state: DopamineInfoView.ViewState = .idle

    private let logger: Logger = .init(subsystem: "DopamineInfo", category: "DopamineInfoModel")

    init(dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
    }

    @MainActor
    func sync(_ type: SyncType) async {
        switch type {
        case .load:
            state = .loading
            do {
                let summary = try await dataSource.getSummary()
                await MainActor.run {
                    state = .loaded(summary)
                }
            } catch {
                state = .loadingFailed
            }
        case .save:
            do {
                try? await dataSource.saveToPersistence()
            } catch {
                logger.error("Error saving to persistence: \(String(describing: error))")
            }
        }
    }
}

extension DopamineInfoModel {
    enum SyncType {
        case load
        case save
    }
}
