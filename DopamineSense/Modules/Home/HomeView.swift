//
//  HomeView.swift
//  DopamineSense
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    let dopamineTrackerView: AnyView
    let detailsView: AnyView

    @State private var state = ViewState()

    var body: some View {
        dashboardView
            .sheet(isPresented: $state.detailsAvailable, content: {
                detailsView
                    .presentationDetents([.fraction(0.4), .fraction(0.9)], selection: $state.selection)
                    .interactiveDismissDisabled()
                    .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.4)))
                    .presentationCornerRadius(32)
                    .ignoresSafeArea()
            })
    }

    @ViewBuilder
    var dashboardView: some View {
        VStack {
            dopamineTrackerView
            Spacer()
            Rectangle()
                .fill(.clear)
                .frame(height: 300)
        }
    }
}

extension HomeView {
    struct ViewState {
        var detailsAvailable: Bool = true
        var selection: PresentationDetent = .fraction(0.4)
    }
}

#if DEBUG
import DopamineInfo
import DopamineTracker

#Preview {
    HomeView(
        dopamineTrackerView: AnyView(DopamineTrackerView(
            configuration: .init(upLabel: "High", middleLabel: "Normal", downLabel: "Low"),
            style: .init(foreground: .foreground, lineColor: .foreground, middleColor: .accent)
        )),
        detailsView: AnyView(DopamineInfoView(token: "", configuration: .init(title: "🌊 Dopamine Sense",
                                                                              subtitle: "Log your activity",
                                                                              erorrMessage: "Failed to load information 🐣")))
    )
}
#endif
