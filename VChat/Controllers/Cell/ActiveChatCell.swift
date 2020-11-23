//
//  ActiveChatCell.swift
//  VChat
//
//  Created by Влад Барченков on 09.10.2020.
//

import UIKit



class ActiveChatCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "ActiveChatCell"
    
    
    let friendImageView = UIImageView()
    let friendName = UILabel(text: "User name", font: .systemFont(ofSize: 14, weight: .semibold))
    let lastMessage = UILabel(text: "How are you?", font: .systemFont(ofSize: 14, weight: .regular))
    let gradientView = GradientView(from: .trailing, to: .leading, startColor: #colorLiteral(red: 0.3450980392, green: 0.3450980392, blue: 0.9137254902, alpha: 1), endColor: #colorLiteral(red: 0.2470588235, green: 0.3333333333, blue: 0.9137254902, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        friendImageView.layer.cornerRadius = 28
        friendImageView.clipsToBounds = true
        lastMessage.textColor = #colorLiteral(red: 0.4235294118, green: 0.4196078431, blue: 0.4549019608, alpha: 1)
        gradientView.layer.cornerRadius  = 4
        gradientView.clipsToBounds = true
        setupConstraints()
        
        self.layer.cornerRadius = 28
        self.clipsToBounds = true
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let chat: MChat = value as? MChat else { return }
        friendName.text = chat.friendUsername
        lastMessage.text = chat.lastMessageContent
        friendImageView.sd_setImage(with: URL(string: chat.friendAvatarStringURL), completed: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup constraints
extension ActiveChatCell {
    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendName.translatesAutoresizingMaskIntoConstraints = false
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        friendImageView.backgroundColor = .orange
        //gradientView.backgroundColor = .black
        
        addSubview(friendImageView)
        addSubview(gradientView)
        addSubview(friendName)
        addSubview(lastMessage)
        
        NSLayoutConstraint.activate([
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendImageView.heightAnchor.constraint(equalToConstant: 56),
            friendImageView.widthAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            friendName.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 17),
            friendName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            lastMessage.topAnchor.constraint(equalTo: friendName.bottomAnchor),
            lastMessage.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 17),
            lastMessage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            lastMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -9)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 8),
            gradientView.widthAnchor.constraint(equalToConstant: 8)
        ])
        
    }
}
