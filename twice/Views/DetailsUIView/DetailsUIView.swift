//
//  DetailsUIView.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import UIKit
import SwiftUI

struct DetailsUIView: UIViewRepresentable {
    let user: GithubUsersResponse

    func makeUIView(context: Context) -> UIView {
        return UILabelComponent(user: user)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No dynamic update needed for this static text
    }
    
    // UIKit component here
    private class UILabelComponent: UIView {
        private let label = UILabel()

        init(user: GithubUsersResponse) {
            super.init(frame: .zero)
            label.text = user.login
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.textColor = .red
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)

            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: topAnchor),
                label.leadingAnchor.constraint(equalTo: leadingAnchor),
                label.trailingAnchor.constraint(equalTo: trailingAnchor),
                label.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

#Preview {
    DetailsUIView(user: .init(login: "123"))
}
