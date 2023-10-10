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
            HStack{
                TextField("", text: $viewModel.message)
                    .frame(height: 20)
                    .cornerRadius(5.0)
                Button {
                    viewModel.send()
                } label: {
                    Image(systemName: Images.send)
                }
                .buttonStyle(BorderlessImageButtonStyle())
            }
            .padding()
            .onSubmit {
                viewModel.send()
            }
        }
    }
}

#Preview {
    return ChatView(viewModel: ChatViewModel.mock)
}
