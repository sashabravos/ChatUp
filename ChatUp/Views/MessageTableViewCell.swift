//
//  MessageTableViewCell.swift
//  ChatUp
//
//  Created by Александра Кострова on 15.04.2023.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    static let identifier = "reusableCell"
    
    lazy var cellSV: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 20.0
        stackView.contentMode = .scaleToFill
        
        [leftAvatar, messageBubble, rightAvatar].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    
    lazy var messageBubble: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5.0
        view.backgroundColor = Colors.purple
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 17.0, weight: .regular)
        label.textAlignment = .left
        label.contentMode = .left
        label.isEnabled = true
        return label
    }()
    
    lazy var rightAvatar: UIImageView = {
        let image = UIImageView.init(image: Avatars.blueFace)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var leftAvatar: UIImageView = {
        let image = UIImageView.init(image: Avatars.purpleFace)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubViews() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(cellSV)
        cellSV.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            cellSV.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            cellSV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            cellSV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            cellSV.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            
            messageBubble.topAnchor.constraint(equalTo: cellSV.topAnchor),
            messageBubble.leadingAnchor.constraint(equalTo: leftAvatar.trailingAnchor, constant: 50.0),
            messageBubble.bottomAnchor.constraint(equalTo: cellSV.bottomAnchor),
            messageBubble.trailingAnchor.constraint(equalTo: rightAvatar.leadingAnchor, constant: -20.0),
            
            messageLabel.topAnchor.constraint(equalTo: messageBubble.topAnchor, constant: 10.0),
            messageLabel.leadingAnchor.constraint(equalTo: messageBubble.leadingAnchor, constant: 10.0),
            messageLabel.trailingAnchor.constraint(equalTo: messageBubble.trailingAnchor, constant: -10.0),
            messageLabel.bottomAnchor.constraint(equalTo: messageBubble.bottomAnchor, constant: -10.0),
            
            rightAvatar.heightAnchor.constraint(equalToConstant: 45.0),
            rightAvatar.widthAnchor.constraint(equalToConstant: 45.0),
            
            leftAvatar.heightAnchor.constraint(equalToConstant: 45.0),
            leftAvatar.widthAnchor.constraint(equalToConstant: 45.0)
        ])
    }
}
