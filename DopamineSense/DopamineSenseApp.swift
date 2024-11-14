//
//  DopamineSenseApp.swift
//  DopamineSense
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import SwiftUI
import SwiftData

import SenseDataSource

@main
struct DopamineSenseApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(model: DopamineModel(dataSource: SenseDataSource()))
        }
    }
}
