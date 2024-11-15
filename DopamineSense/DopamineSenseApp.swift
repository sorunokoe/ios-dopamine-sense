//
//  DopamineSenseApp.swift
//  DopamineSense
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import SwiftData
import SwiftUI

import DopamineInfo
import DopamineTracker

@main
struct DopamineSenseApp: App {
    let dopamineTrackerView: AnyView = .init(DopamineTrackerView(
        configuration: .init(
            upLabel: "High lv. dopamine",
            middleLabel: "Normal lv. dopamine",
            downLabel: "Low lv. dopamine"
        ),
        style: .init(foreground: .foreground, lineColor: .accent, middleColor: .yellow)
    ))

    let detailsView: AnyView = .init(DopamineInfoView(
        token: ProcessInfo().environment["GPT_TOKEN"] ?? "",
        configuration: .init(
            title: "🌊 Dopamine Sense",
            subtitle: "Log your activity",
            erorrMessage: "Failed to load information 🐣"
        )
    ))

    var body: some Scene {
        WindowGroup {
            HomeView(
                dopamineTrackerView: dopamineTrackerView,
                detailsView: detailsView
            )
        }
    }
}
