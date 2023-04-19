//
//  ChatViewController.swift
//  ChatUp
//
//  Created by Александра Кострова on 05.04.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController, ChatViewDelegate {
    
    private let chatView = ChatView()
    private let samples = Samples()
    
    let dataBase = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ChatUP!"
        chatView.delegate = self
        samples.setMyView(chatView, self.view)
        
        addLogOutButton()
        loadMessages()
        
        chatView.sendButton.addTarget(self, action: #selector(sendButtonPressed(sender:)), for: .touchUpInside)
    }
    
    func loadMessages() {
        dataBase.collection("messages")
            .order(by: "data")
            .addSnapshotListener { (querySnapshot, error) in
                self.chatView.messages = []
                
                if let loadMessagesError = error {
                    print("There was an issue retrieving data from Firestore. \(loadMessagesError)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let messageSender = data["sender"] as? String, let messageBody = data["body"] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.chatView.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.chatView.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
    }
    
    // MARK: - LogOut Button
    private func addLogOutButton() {
        navigationItem.hidesBackButton = true
        lazy var logOutButton = UIBarButtonItem(title: "Log Out",
                                                style: .plain, target: self,
                                                action: #selector(logOutTapped(sender:)))
        navigationItem.rightBarButtonItem = logOutButton
    }
    
    @objc func logOutTapped(sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    // MARK: - Send Button's methods
    @objc func sendButtonPressed(sender: UIButton) {
        if let messageBody = chatView.messageTF.text,
           let messageSender = Auth.auth().currentUser?.email {
            dataBase.collection(Samples.FStore.collectionName).addDocument(data: [
                Samples.FStore.senderField: messageSender,
                Samples.FStore.bodyField: messageBody,
                Samples.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    
                    DispatchQueue.main.async {
                        self.chatView.messageTF.text = ""
                    }
                }
            }
        }
    }
}
