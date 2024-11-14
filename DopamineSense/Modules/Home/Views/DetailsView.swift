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
                
            }
        }
        .padding(32)
    }
}

#if DEBUG
#Preview {
    DetailsView()
}
#endif
