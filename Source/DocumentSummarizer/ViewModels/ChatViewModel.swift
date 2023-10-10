//
//  ChatViewModel.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/10/23.
//

import SwiftUI

@Observable
class ChatViewModel {
    var messages: [Message] = []
    var message: String = ""
    
    init(messages: [Message] = [], message: String = "") {
        self.messages = messages
        self.message = message
    }
    
    func send() {
        messages.append(Message(message: message, user: "Bard"))
        message = ""
    }
}

struct Message: Identifiable {
    enum Sender {
        case user
        case bot
    }
    
    let id = UUID().uuidString
    var message: String
    var user: String
    var sender: Sender = .bot
}

extension ChatViewModel {
    static var mock: ChatViewModel {
        return ChatViewModel(messages: [
            Message(message: "hello world", user: "john"),
            Message(message: "hello world", user: "john"),
            Message(message: "hello world", user: "john"),
        ])
    }
}
