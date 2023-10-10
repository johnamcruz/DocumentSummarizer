//
//  ChatBubbleView.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/10/23.
//

import SwiftUI

struct ChatBubbleView: View {
    let message: Message
    
    var body: some View {
        HStack {
            Image(systemName: Images.person)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 10.0,
                    bottomLeading: 10.0,
                    bottomTrailing: 10.0,
                    topTrailing: 10.0))
                .foregroundStyle(Color(red: 0.13, green: 0.21, blue: 0.29))
                .overlay {
                    Text(message.message)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                Text(message.user)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

#Preview {
    ChatBubbleView(message: Message(message: "Hi John", user: "John Cruz"))
}
