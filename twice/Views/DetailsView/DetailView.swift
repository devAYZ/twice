//
//  DetailView.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import SwiftUI

struct DetailView: View {
    let item: Item

    var body: some View {
        CustomUIView(text: item.description)
            .frame(maxWidth: .infinity, minHeight: 100)
    }
}

#Preview {
    DetailView(item: .init(title: "Ayo", description: "Ayo 1"))
}
