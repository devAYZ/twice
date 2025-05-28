//
//  ListCellView.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import SwiftUI

struct ListCellView: View {
    let user: GithubUsersResponse

    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            
            AsyncImage(url: .init(string: user.avatarUrl ?? "")) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundColor(.blue)
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 45, height: 45)
            .cornerRadius(22.5)
            .overlay {
                Circle().stroke(Color.green, lineWidth: 0.5)
            }
            .shadow(radius: 7)
            
            VStack(alignment: .leading) {
                Text(user.login.unwrap)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text("\(user.type.unwrap) - \(user.id ?? .zero)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}


#Preview {
    ListCellView(user: .init(login: "Ayo"))
}
