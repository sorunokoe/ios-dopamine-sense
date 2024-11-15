//  DetailsView.swift
//  DopamineSense
//
//  Created by SALGARA, YESKENDIR on 13.11.24.
//

import ChatGPTService
import SenseUI
import SwiftUI

public struct DopamineInfoView: View {
    @Environment(\.scenePhase) private var scenePhase

    @StateObject var model: DopamineInfoModel
    let configuration: Configuration

    public init(token: String, configuration: Configuration) {
        let dataSource = DataSource(
            senseInfoService: SenseInfoService(llmModel: ChatGPTService(token: token)),
            persistence: Persistence()
        )
        self._model = StateObject(wrappedValue: DopamineInfoModel(dataSource: dataSource))
        self.configuration = configuration
    }

    public var body: some View {
        content
            .onChange(of: scenePhase) { _, phase in
                Task {
                    if phase == .inactive {
                        await model.sync(.save)
                    }
                }
            }
            .task {
                await model.sync(.load)
            }
    }

    @ViewBuilder
    private var content: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 32) {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(configuration.title)
                            .font(.system(size: 24, weight: .medium))
                        Text(configuration.subtitle)
                            .font(.system(size: 20, weight: .regular))
                            .opacity(0.8)
                    }
                }
                infoView
            }
            .padding(32)
        }
        .id(ID.infoScrollViewId.rawValue)
    }

    @ViewBuilder
    private var infoView: some View {
        switch model.state {
        case .idle:
            EmptyView()
        case .loading:
            ProgressView()
                .padding(12)
                .background(.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(maxWidth: .infinity)
        case .loaded(let answers):
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(answers, id: \.self) { answer in
                    Text(answer)
                        .font(.system(size: 20, weight: .regular))
                }
            }
            .padding(12)
            .background(.blue.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(maxWidth: .infinity)
        case .loadingFailed:
            VStack(alignment: .center, spacing: 8) {
                Text(configuration.erorrMessage)
                    .font(.system(size: 20, weight: .regular))
                    .opacity(0.8)
            }
            .padding(12)
            .background(.red.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(maxWidth: .infinity)
        }
    }
}

extension DopamineInfoView {
    public struct Configuration {
        let title: String
        let subtitle: String
        let erorrMessage: String
        
        public init(title: String, subtitle: String, erorrMessage: String) {
            self.title = title
            self.subtitle = subtitle
            self.erorrMessage = erorrMessage
        }
    }
    
    enum ViewState {
        case idle
        case loading
        case loaded([String])
        case loadingFailed
    }

    public enum ID: String {
        case infoScrollViewId
    }
}

#if DEBUG
import ChatGPTService
import SensePersistence

#Preview {
    DopamineInfoView(
        token: "",
        configuration: .init(
            title: "🌊 Dopamine Sense",
            subtitle: "Log your activity",
            erorrMessage: "Failed to load information 🐣"
        )
    )
}
#endif
