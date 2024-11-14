//
//  ContentView.swift
//  DopamineSense
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import SwiftUI
import SwiftData

import SenseUI

struct ContentView: View {

    var body: some View {
        DashboardView(style: .init(lineColor: .indigo,
                                   middleColor: .yellow),
                      configuration: .init(upLabel: "High level of Dopamine",
                                           middleLabel: "Regular",
                                           downLabel: "Low level of Dopamine"),
                      dataPoints: <#[DataPoint]#>)
    }
}

#Preview {
    ContentView()
}
