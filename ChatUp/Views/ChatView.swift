//
//  ChatView.swift
//  ChatUp
//
//  Created by Александра Кострова on 10.04.2023.
//

import UIKit

protocol ChatViewDelegate: AnyObject {
}

final class ChatView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: ChatViewDelegate?
    
    private var samples = Samples()
    private let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)
    
    var messages: [Message] = []
    
    lazy var messageTF: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Write a message...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray .withAlphaComponent(0.7)]
        )
        textField.textAlignment = .natural
        textField.textColor = .black
        textField.minimumFontSize = 17.0
        textField.font = UIFont.systemFont(ofSize: 17.0)
        textField.contentHorizontalAlignment = .left
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 5.0
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 5.0
        textField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        textField.layer.shadowColor = UIColor.gray.cgColor
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.tintColor = Samples.Colors.lightPurple
        button.titleLabel!.numberOfLines = 0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        button.setImage(UIImage(systemName: "paperplane.fill", withConfiguration: largeConfig), for: .normal)
        return button
    }()
    
    private lazy var messageView: UIView = {
        let view = samples.makeView()
        
        [messageTF, sendButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.identifier)
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubViews()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubViews() {
        self.backgroundColor = Samples.Colors.purple
        
        [tableView, messageView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            messageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            messageView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            messageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            messageView.heightAnchor.constraint(equalToConstant: 60.0),
            
            messageTF.heightAnchor.constraint(equalToConstant: 40.0),
            messageTF.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 20.0),
            messageTF.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 20.0),
            
            sendButton.heightAnchor.constraint(equalTo: messageTF.heightAnchor),
            sendButton.widthAnchor.constraint(equalTo: sendButton.heightAnchor),
            sendButton.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 20.0),
            sendButton.leadingAnchor.constraint(equalTo: messageTF.trailingAnchor, constant: 20.0),
            sendButton.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -20.0)
        ])
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.identifier,
                                                       for: indexPath) as? MessageTableViewCell else {
            return UITableViewCell()
        }
        cell.messageLabel.text = "\(messages[indexPath.row].sender): \(messages[indexPath.row].body)"
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
