//
//  AutoTrackViewB.swift
//  swift_ui_demo
//
//  Created by renwei on 2026/8/27.
//

import SwiftUI

struct AutoTrackViewB: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTag: String = "none"

    var body: some View {
        VStack(spacing: 20) {
            Text("AutoTrackViewB")
                .font(.largeTitle)

            Text("当前标签: \(selectedTag)")
                .font(.subheadline)
                .foregroundColor(.gray)

            HStack(spacing: 10) {
                Button("标记为 VIP") {
                    selectedTag = "vip"
                    QTPageTracker.updateProperties(["user_tag": "vip"], forPage: "AutoTrackViewB")
                }
                .font(.caption)
                .padding(8)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(6)

                Button("标记为普通") {
                    selectedTag = "normal"
                    QTPageTracker.updateProperties(["user_tag": "normal"], forPage: "AutoTrackViewB")
                }
                .font(.caption)
                .padding(8)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(6)
            }

            Button {
                dismiss()
            } label: {
                Text("返回上个界面")
                    .font(.headline)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("View B")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            QTPageTracker.beginPage("AutoTrackViewB")
            // 进入页面时设置初始属性
            QTPageTracker.updateProperties([
                "referrer": "AutoTrackViewA",
                "visit_type": "detail"
            ], forPage: "AutoTrackViewB")
        }
        .onDisappear {
            QTPageTracker.endPage("AutoTrackViewB")
        }
    }
}

#Preview {
    NavigationStack {
        AutoTrackViewB()
    }
}
