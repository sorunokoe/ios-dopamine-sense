//
//  ContentView.swift
//  DopamineSense
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import SwiftData
import SwiftUI

import SenseDataSource
import SenseUI

struct ContentView: View {

    @State var detailsAvailable: Bool = true
    @State var selection: PresentationDetent = .fraction(0.4)
    @State private var sheetContentHeight = CGFloat(0)
    @State private var selectedActivity: SenseActivityType?

    var body: some View {
        dashboardView
            .sheet(isPresented: $detailsAvailable, content: {
                detailsView
                    .background {
                        GeometryReader { proxy in
                            Color.clear
                                .task {
                                    sheetContentHeight = proxy.size.height
                                }
                        }
                    }
                    .presentationDetents(
                        [.fraction(0.4)],
                        selection: $selection
                    )
                    .interactiveDismissDisabled()
                    .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.4)))
                    .presentationCornerRadius(32)
                    .ignoresSafeArea()
            })
    }

    @ViewBuilder
    var dashboardView: some View {
        VStack {
            DashboardView(
                style: .init(
                    lineColor: .indigo,
                    middleColor: .yellow
                ),
                configuration: .init(
                    upLabel: "High level of Dopamine",
                    middleLabel: "Regular",
                    downLabel: "Low level of Dopamine"
                ),
                dataPoints: dataPoints
            )
            Spacer()
            Rectangle()
                .fill(.clear)
                .frame(height: sheetContentHeight)
        }
    }
}

#Preview {
    ContentView()
}
