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
        HStack(alignment: .top) {
            Image(systemName: Images.person)
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
                .padding(EdgeInsets(top: 7, leading: 0, bottom: 0, trailing: 0))
            VStack(alignment: .leading) {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 10.0,
                    bottomLeading: 10.0,
                    bottomTrailing: 10.0,
                    topTrailing: 10.0))
                .foregroundStyle(Color(red: 0.13, green: 0.21, blue: 0.29))
                .overlay {
                    Text(message.message)
                        .foregroundStyle(.secondary)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                Text(message.user)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
        }
        .padding(5)
    }
}

#Preview {
    ChatBubbleView(message: Message.mock)
}
