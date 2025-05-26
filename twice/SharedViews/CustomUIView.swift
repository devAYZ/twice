//
//  CustomUIView.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import UIKit
import SwiftUI

struct CustomUIView: UIViewRepresentable {
    let text: String

    func makeUIView(context: Context) -> UIView {
        return UILabelComponent(text: text)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No dynamic update needed for this static text
    }
    
    // UIKit component here
    private class UILabelComponent: UIView {
        private let label = UILabel()

        init(text: String) {
            super.init(frame: .zero)
            label.text = text
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
