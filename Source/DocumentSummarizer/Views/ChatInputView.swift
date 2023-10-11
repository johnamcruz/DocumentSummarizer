//
//  ChatInputView.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/10/23.
//

import SwiftUI

struct ChatInputView: View {
    @Bindable var viewModel: ChatViewModel
    var body: some View {
        HStack{
            TextField("",
                      text: $viewModel.message,
                      prompt: Text(LocalizedStringKey(Localization.tooltip)),
                      axis: .vertical)
                .frame(minHeight: 30)
                .textFieldStyle(.plain)
            Button {
                viewModel.send()
            } label: {
                Image(systemName: Images.send)
                    .tint(.secondary)
            }
            .buttonStyle(BorderlessImageButtonStyle())
        }
        .padding(10)
        .border(.secondary)
        .padding()
    }
}

#Preview {
    ChatInputView(viewModel: ChatViewModel.mock)
}
