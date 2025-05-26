//
//  SearchView.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import SwiftUI

struct SearchView: View {
    
    // MARK: Properties
    var placeholder: String = "Search List"
    @Binding var text: String
    var icon: Image = Image(systemName: "magnifyingglass")
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 12) {
                icon
                TextField(placeholder, text: $text)
                    .font(.system(size: 17))
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .submitLabel(.done)
            }
            .padding(12)
            .background(Color.gray.opacity(0.15))
            .cornerRadius(8)
        }
    }
}

#Preview {
    SearchView(text: .constant("Ayo"))
}
