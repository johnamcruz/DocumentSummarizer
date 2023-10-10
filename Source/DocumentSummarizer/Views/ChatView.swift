//
//  ChatView.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/10/23.
//

import SwiftUI

struct ChatView: View {
    @State var messages: [String] = []
    @State var message: String = ""
    
    var body: some View {
        VStack {
            List(messages, id: \.self) { message in
                ChatBubbleView(message: message)
            }
            Spacer()
            HStack{
                TextField("", text: $message)
                Button {
                    messages.append(message)
                    message = ""
                } label: {
                    Image(systemName: Images.send)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ChatView()
}
