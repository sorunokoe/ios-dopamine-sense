//
//  DopamineSenseApp.swift
//  DopamineSense
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import SwiftData
import SwiftUI

import DopamineTracker

@main
struct DopamineSenseApp: App {
    let dopamineTrackerView: AnyView = .init(DopamineTrackerView(
        configuration: .init(upLabel: "High lv. dopamine",
                             middleLabel: "Normal lv. dopamine",
                             downLabel: "Low lv. dopamine"),
        style: .init(foreground: .foreground, lineColor: .accent, middleColor: .yellow)
    ))
    
    let detailsView: AnyView = .init(Text("Details"))

    var body: some Scene {
        WindowGroup {
            HomeView(
                dopamineTrackerView: dopamineTrackerView,
                detailsView: detailsView
            )
        }
    }
}
