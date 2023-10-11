//
//  ChatView.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/10/23.
//

import SwiftUI

struct ChatView: View {
    @State var viewModel = ChatViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.messages) { message in
                ChatBubbleView(message: message)
                    .listRowSeparator(.hidden)
            }
            Spacer()
            ChatInputView(viewModel: viewModel)
            .onSubmit {
                viewModel.send()
            }
        }
    }
}

#Preview {
    return ChatView(viewModel: ChatViewModel.mock)
}
