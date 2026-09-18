//
//  ContentView.swift
//  swift_ui_demo
//
//  Created by renwei on 2026/8/26.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")

                NavigationLink(value: "AutoTrackViewA") {
                    Text("跳转到 AutoTrackViewA")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .navigationTitle("首页")
            .navigationDestination(for: String.self) { value in
                if value == "AutoTrackViewA" {
                    AutoTrackViewA()
                }
            }
        }
        .onChange(of: path, initial: true) { _, newPath in
            if newPath.isEmpty {
                QTPageTracker.beginPage("homePage")
            } else {
                QTPageTracker.endPage("homePage")
            }
        }
    }
}

#Preview {
    ContentView()
}
