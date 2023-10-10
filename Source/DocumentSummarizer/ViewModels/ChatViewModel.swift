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
        guard !message.isEmpty else {
            return
        }
        
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
            Message(message: "SwiftUI’s TextField view has no styling by default, which means it’s an empty space on the screen. If that fits the style you want, great – you’re done. But many of us will prefer to add a border around the text field to make it clearer.", 
                    user: "john",
                    sender: .bot),
            Message(message: "SwiftUI’s TextField view has no styling by default, which means it’s an empty space on the screen. If that fits the style you want, great – you’re done. But many of us will prefer to add a border around the text field to make it clearer.",
                    user: "john",
                    sender: .user),
            Message(message: "SwiftUI’s TextField view has no styling by default, which means it’s an empty space on the screen. If that fits the style you want, great – you’re done. But many of us will prefer to add a border around the text field to make it clearer.",
                    user: "john",
                    sender: .bot),
        ])
    }
}

extension Message {
    static var mock: Message {
        Message(message: "SwiftUI’s TextField view has no styling by default, which means it’s an empty space on the screen. If that fits the style you want, great – you’re done. But many of us will prefer to add a border around the text field to make it clearer.",
                user: "John",
                sender: .bot)
    }
}
