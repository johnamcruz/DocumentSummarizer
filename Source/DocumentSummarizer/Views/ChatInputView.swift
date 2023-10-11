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
                .disableAutocorrection(true)
            Button {
                viewModel.send()
            } label: {
                Image(systemName: viewModel.message.isEmpty ? Images.circle : Images.send)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(viewModel.message.isEmpty ? .secondary.opacity(0.75) : .secondary)
                    .frame(width: 20, height: 20)
                    .padding()
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
