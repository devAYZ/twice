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
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
                    .overlay {
                        Circle().stroke(Color.blue, lineWidth: 0.5)
                    }
            } placeholder: {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            }
            .shadow(radius: 7)
            
            VStack(alignment: .leading) {
                Text(user.login.tryValue)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("\(user.login.tryValue) - \(user.id ?? .zero)")
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
