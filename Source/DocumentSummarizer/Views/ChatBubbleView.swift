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
                HStack(alignment: .top){
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
    }
}

#Preview {
    ChatBubbleView(message: Message.mock)
}
