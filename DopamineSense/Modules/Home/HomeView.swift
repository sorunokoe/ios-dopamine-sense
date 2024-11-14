//
//  HomeView.swift
//  DopamineSense
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import SwiftData
import SwiftUI

import SenseDataSource
import SenseUI

struct HomeView: View {
    
    @ObservedObject var model: DopamineModel
    
    @State private var detailsAvailable: Bool = true
    @State private var selection: PresentationDetent = .fraction(0.4)
    @State private var sheetContentHeight = CGFloat(0)
    
    init(model: DopamineModel) {
        self.model = model
    }

    var body: some View {
        dashboardView
            .sheet(isPresented: $detailsAvailable, content: {
                DetailsView(model: model)
                    .background {
                        GeometryReader { proxy in
                            Color.clear
                                .task {
                                    sheetContentHeight = proxy.size.height
                                }
                        }
                    }
                    .presentationDetents([.fraction(0.4)], selection: $selection)
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
                    lineColor: .accent,
                    middleColor: .primary.opacity(0.8)
                ),
                configuration: .init(
                    upLabel: Configurations.upLabel,
                    middleLabel: Configurations.middleLabel,
                    downLabel: Configurations.downLabel
                ),
                dataPoints: model.dataPoints
            )
            Spacer()
            Rectangle()
                .fill(.clear)
                .frame(height: sheetContentHeight)
        }
    }
}

private extension HomeView {
 
    struct Configurations {
        static let upLabel: String = "High level of Dopamine"
        static let middleLabel: String = "Normal level of Dopamine"
        static let downLabel: String = "Low level of Dopamine"
    }
    
}

#if DEBUG
#Preview {
    HomeView(model: DopamineModel(dataSource: SenseDataSource()))
}
#endif
