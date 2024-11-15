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

public struct DopamineTrackerView: View {
    @StateObject var model: DopamineModel<SenseDataSource> = DopamineModel(dataSource: SenseDataSource())

    private let configuration: Configuration
    private let style: Style
    @State private var state = ViewState()

    public init(
        configuration: Configuration,
        style: Style
    ) {
        self.configuration = configuration
        self.style = style
    }

    public var body: some View {
        VStack {
            ZStack {
                DashboardView(
                    style: .init(
                        lineColor: style.lineColor,
                        middleColor: style.middleColor
                    ),
                    configuration: .init(
                        upLabel: configuration.upLabel,
                        middleLabel: configuration.middleLabel,
                        downLabel: configuration.downLabel
                    ),
                    dataPoints: model.map(timeline: model.dataPoints)
                )
                VStack(alignment: .trailing, spacing: 0) {
                    VStack(alignment: .trailing) {
                        ForEach(SenseActivityType.allCases, id: \.title) { activity in
                            Button {
                                withAnimation {
                                    model.log(activity: activity)
                                    state.showActivities = false
                                }
                            } label: {
                                Label(activity.title, systemImage: activity.icon)
                                    .frame(maxWidth: .infinity)
                                    .font(.system(size: 18, weight: .regular))
                                    .padding(12)
                                    .background(.secondary.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .frame(maxWidth: 200)
                    .padding(16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .opacity(state.showActivities ? 1 : 0)
                    Button {
                        withAnimation {
                            state.showActivities.toggle()
                        }
                    } label: {
                        Image(systemName: state.showActivities ? "xmark.circle.fill" : "circle.hexagongrid")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .padding(16)
                            .background(.blue.opacity(0.1))
                            .clipShape(Circle())
                            .padding(.horizontal, 32)
                    }
                    .buttonStyle(.plain)
                }
                .frame(height: 250)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }
    }
}

public extension DopamineTrackerView {
    struct Style {
        let foreground: Color
        let lineColor: Color
        let middleColor: Color
        
        public init(foreground: Color, lineColor: Color, middleColor: Color) {
            self.foreground = foreground
            self.lineColor = lineColor
            self.middleColor = middleColor
        }
    }

    struct Configuration {
        let upLabel: String
        let middleLabel: String
        let downLabel: String
        
        public init(upLabel: String, middleLabel: String, downLabel: String) {
            self.upLabel = upLabel
            self.middleLabel = middleLabel
            self.downLabel = downLabel
        }
    }

    struct ViewState {
        var showActivities: Bool = false
    }
}

#if DEBUG
#Preview {
    DopamineTrackerView(
        configuration: .init(
            upLabel: "High level of dopamine",
            middleLabel: "Normal level of dopamine",
            downLabel: "Low level of dopamine"
        ),
        style: .init(
            foreground: .blue,
            lineColor: .indigo,
            middleColor: .red
        )
    )
}
#endif
