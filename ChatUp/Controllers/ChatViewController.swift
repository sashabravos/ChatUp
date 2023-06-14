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
        dataBase.collection(FStore.collectionName)
            .order(by: FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                self.chatView.messages = []
                
                if let loadMessagesError = error {
                    print("There was an issue retrieving data from Firestore. \(loadMessagesError)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let messageSender = data[FStore.senderField] as? String,
                                let messageBody = data[FStore.bodyField] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.chatView.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.chatView.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.chatView.messages.count - 1, section: 0)
                                    self.chatView.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
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
            dataBase.collection(FStore.collectionName).addDocument(data: [
                FStore.senderField: messageSender,
                FStore.bodyField: messageBody,
                FStore.dateField: Date().timeIntervalSince1970
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
