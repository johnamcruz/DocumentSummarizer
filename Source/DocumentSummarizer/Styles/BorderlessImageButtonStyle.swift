//
//  BorderlessImageButtonStyle.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/10/23.
//

import SwiftUI

struct BorderlessImageButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(.clear)
            .overlay(configuration.label)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

extension ButtonStyle where Self == BorderlessImageButtonStyle {
    static var borderlessImageButton: Self {
        return .init()
    }
}
