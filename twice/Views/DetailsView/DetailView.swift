//
//  DetailView.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import SwiftUI

struct DetailView: View {
    let user: GithubUsersResponse

    var body: some View {
        CustomUIView(text: user.login.tryValue)
            .frame(maxWidth: .infinity, minHeight: 100)
    }
}

#Preview {
    DetailView(user: .init(login: "123"))
}
