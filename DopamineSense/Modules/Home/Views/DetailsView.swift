//
//  DetailsView.swift
//  DopamineSense
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import SwiftUI
import SenseUI
import SenseDataSource

struct DetailsView: View {
    @StateObject var model: DopamineModel
    @State var selectedActivity: SenseActivityType?
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("🌊 Dopamine Sense")
                        .font(.system(size: 24, weight: .medium))
                    Text("Log your activity")
                        .font(.system(size: 20, weight: .regular))
                        .opacity(0.8)
                }
                LazyVStack {
                    ForEach(SenseActivityType.allCases, id: \.title) { activity in
                        Button {
                            selectedActivity = activity
                        } label: {
                            Label(activity.title, systemImage: activity.icon)
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 18, weight: .regular))
                                .padding(12)
                                .background(.secondary.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .opacity(selectedActivity == activity ? 1 : 0.5)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            if let selectedActivity {
                Button {
                    withAnimation {
                        model.log(activity: selectedActivity)
                        self.selectedActivity = nil
                    }
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 18, weight: .regular))
                        .padding(12)
                        .foregroundStyle(Color.foreground)
                        .background(.primary.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(32)
    }
}

#if DEBUG
#Preview {
    DetailsView(model: .init(dataSource: SenseDataSource()))
}
#endif
