//
//  WaitingChatCell.swift
//  VChat
//
//  Created by Влад Барченков on 09.10.2020.
//

import UIKit

class WaitingChatCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseId: String = "WaitingChatCell"
    
    let friendImageView = UIImageView()
    let friendNameLabel = UILabel(text: "User", font: .systemFont(ofSize: 14, weight: .regular))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        friendNameLabel.textAlignment = .center
        friendImageView.layer.cornerRadius = 28
        friendImageView.clipsToBounds = true
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        setupConstraints()
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let chat: MChat = value as? MChat else { return }
        friendImageView.sd_setImage(with: URL(string: chat.friendAvatarStringURL), completed: nil)
        friendNameLabel.text = chat.friendUsername
        
    }
    
    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(friendImageView)
        addSubview(friendNameLabel)
        
        NSLayoutConstraint.activate([
            friendImageView.topAnchor.constraint(equalTo: self.topAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            friendImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            friendImageView.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            friendNameLabel.topAnchor.constraint(equalTo: friendImageView.bottomAnchor),
            friendNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            friendNameLabel.heightAnchor.constraint(equalToConstant: 19)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
