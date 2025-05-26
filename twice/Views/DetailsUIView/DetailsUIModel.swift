//
//  DetailsUIModel.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import Foundation

struct DetailsInfo {
    var title: String
    var value: String?
    
    static func details(_ user: GithubUsersResponse) -> [DetailsInfo] {
        [
            DetailsInfo(title: "ID:", value: "\(user.id ?? .zero)"),
            DetailsInfo(title: "Login:", value: user.login),
            DetailsInfo(title: "Type:", value: user.type),
            DetailsInfo(title: "View type:", value:user.userViewType),
            DetailsInfo(title: "Profile URL:", value: user.avatarUrl),
            DetailsInfo(title: "User URL:", value: user.url)
        ]
    }
}
