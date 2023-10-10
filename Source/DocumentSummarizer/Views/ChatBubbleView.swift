//
//  ChatBubbleView.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/10/23.
//

import SwiftUI

struct ChatBubbleView: View {
    let message: String
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(message)
                    .padding()
                    .background(Color(red: 0.13, green: 0.21, blue: 0.29))
                    .cornerRadius(10)
                Text("Bard")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

#Preview {
    ChatBubbleView(message: "Hello world")
}
