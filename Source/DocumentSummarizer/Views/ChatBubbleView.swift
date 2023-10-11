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
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: message.sender == .user ? .center : .top){
                    Image(systemName: Images.person)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 10)
                    Text(message.message)
                        .foregroundColor(.white)
                        .textSelection(.enabled)
                }
                .padding([.top, .bottom])
                .padding(.leading, 10)
            }
            Spacer()
        }
        .background(message.sender == .user ? Color(red: 53/255, green: 54/255, blue: 65/255) : Color(red: 68/255, green: 70/255, blue: 83/255))
        .shadow(radius: message.sender == .user ? 0 : 0.5)
    }
}

#Preview {
    ChatBubbleView(message: Message.mock)
}
