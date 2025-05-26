//
//  ListView.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct ListView: View {
    let items = [
        Item(title: "Item 1", description: "This is item 1"),
        Item(title: "Item 2", description: "This is item 2")
    ]

    var body: some View {
        NavigationView {
            List(items) { item in
                NavigationLink(destination: DetailView(item: item)) {
                    Text(item.title)
                }
            }
            .navigationTitle("Github Users")
        }
    }
}

#Preview {
    ListView()
}
