//
//  DetailsUIView.swift
//  twice
//
//  Created by Ayokunle Fatokimi on 26/05/2025.
//

import UIKit
import SwiftUI
import Kingfisher

struct DetailsUIView: UIViewRepresentable {
    let user: GithubUsersResponse

    func makeUIView(context: Context) -> UIView {
        return UIViewComponent(user: user)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No dynamic update needed for this static text
    }
    
    // UIKit component here
    private class UIViewComponent: UIView {

        init(user: GithubUsersResponse) {
            super.init(frame: .zero)
            
            
            addSubview(scrollView)
            
            setupScrollView()
            setupProfileImage(imageURL: user.avatarUrl ?? "")
            setupNameLabel(login: user.login.unwrap)
            
            setupInfoContainer(user)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private let scrollView = UIScrollView()
        private let contentView = UIView()
        private let profileImageView = UIImageView()
        private let nameLabel = UILabel()
        private var personalInfoData = [String]()
        
        private func setupScrollView() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.addSubview(contentView)
            
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        }
        
        private func setupProfileImage(imageURL: String) {
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            profileImageView.kf.setImage(
                with: URL(string: imageURL),
                placeholder: UIImage(systemName: "person")
            )
            profileImageView.layer.cornerRadius = 50
            profileImageView.layer.borderWidth = 2
            profileImageView.layer.borderColor = UIColor.systemGreen.cgColor
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.clipsToBounds = true
            
            contentView.addSubview(profileImageView)
            
            NSLayoutConstraint.activate([
                profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                profileImageView.widthAnchor.constraint(equalToConstant: 100),
                profileImageView.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
        
        private func setupNameLabel(login: String) {
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
            nameLabel.text = login
            nameLabel.textAlignment = .center
            
            contentView.addSubview(nameLabel)
            
            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15),
                nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        }
        
        private func setupInfoContainer(_ user: GithubUsersResponse) {
            let containerStack = UIStackView()
            containerStack.axis = .vertical
            containerStack.spacing = 18
            containerStack.translatesAutoresizingMaskIntoConstraints = false
            
            let headerStack = UIStackView()
            headerStack.axis = .horizontal
            headerStack.spacing = 5
            
            let titleLabel = UILabel()
            titleLabel.text = "Details Information"
            titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
            
            headerStack.addArrangedSubview(titleLabel)
            
            let detailsStack = UIStackView()
            detailsStack.axis = .vertical
            detailsStack.spacing = 30
            detailsStack.backgroundColor = .white
            detailsStack.translatesAutoresizingMaskIntoConstraints = false
            
            for info in DetailsInfo.details(user) {
                let row = UIStackView()
                row.axis = .horizontal
                row.spacing = 10
                row.distribution = .equalSpacing
                
                let titleLabel = UILabel()
                titleLabel.text = info.title
                titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
                
                let valueLabel = UILabel()
                valueLabel.text = info.value
                valueLabel.font = .systemFont(ofSize: 12)
                valueLabel.numberOfLines = 1
                
                row.addArrangedSubview(titleLabel)
                row.addArrangedSubview(valueLabel)
                detailsStack.addArrangedSubview(row)
                
                containerStack.addArrangedSubview(headerStack)
                containerStack.addArrangedSubview(detailsStack)
                
                contentView.addSubview(containerStack)
                
                NSLayoutConstraint.activate([
                    containerStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 35),
                    containerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                    containerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                    containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
                ])
            }
        }
    }
}

#Preview {
    DetailsUIView(user: .init(login: "123"))
}
