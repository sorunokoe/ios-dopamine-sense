//
//  DetailsView.swift
//  DopamineSense
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import SenseDataSource
import SenseUI
import SwiftUI

struct DetailsView: View {
    @StateObject var model: DopamineModel<SenseDataSource>

    let configuration: Configuration
    let style: Style
    @State var state = ViewState()

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(configuration.title)
                        .font(.system(size: 24, weight: .medium))
                    Text(configuration.subtitle)
                        .font(.system(size: 20, weight: .regular))
                        .opacity(0.8)
                }
                LazyVStack {
                    ForEach(SenseActivityType.allCases, id: \.title) { activity in
                        Button {
                            state.selectedActivity = activity
                        } label: {
                            Label(activity.title, systemImage: activity.icon)
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 18, weight: .regular))
                                .padding(12)
                                .background(.secondary.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .opacity(state.selectedActivity == activity ? 1 : 0.5)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            if let selectedActivity = state.selectedActivity {
                Button {
                    withAnimation {
                        model.log(activity: selectedActivity)
                        self.state.selectedActivity = nil
                    }
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 18, weight: .regular))
                        .padding(12)
                        .foregroundStyle(style.foreground)
                        .background(.primary.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(32)
    }
}

extension DetailsView {
    struct Style {
        let foreground: Color
    }

    struct Configuration {
        let title: String
        let subtitle: String
    }

    struct ViewState {
        var selectedActivity: SenseActivityType?
    }
}

#if DEBUG
#Preview {
    DetailsView(
        model: .init(dataSource: SenseDataSource()),
        configuration: .init(
            title: "🌊 Dopamine Sense",
            subtitle: "Log your activity"
        ),
        style: .init(foreground: .blue)
    )
}
#endif
