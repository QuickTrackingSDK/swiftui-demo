//
//  AutoTrackViewA.swift
//  swift_ui_demo
//
//  Created by renwei on 2026/8/27.
//

import SwiftUI

struct AutoTrackViewA: View {
    @State private var clickCount = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("AutoTrackViewA")
                .font(.largeTitle)

            Button("点击上报属性 (已点击 \(clickCount) 次)") {
                clickCount += 1
                // 在按钮点击时动态更新页面属性
                QTPageTracker.updateProperties([
                    "button_clicked": "yes",
                    "click_count": clickCount,
                    "action": "set_property"
                ], forPage: "AutoTrackViewA")
            }
            .font(.headline)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(8)

            NavigationLink(destination: AutoTrackViewB()) {
                Text("跳转到 AutoTrackViewB")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("View A")
        .navigationBarTitleDisplayMode(.inline)
        .qtPage("AutoTrackViewA")
    }
}

#Preview {
    NavigationStack {
        AutoTrackViewA()
    }
}
