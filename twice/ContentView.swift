//
//  ContentView.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 22/05/2025.
//

import SwiftUI
import twiceNetworking

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    func test() {
        let emp = EmptyRequest()
    }
}

#Preview {
    ContentView()
}
