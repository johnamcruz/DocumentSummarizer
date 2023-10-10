//
//  MainView.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/6/23.
//

import SwiftUI
import CoreML

struct MainView: View {
    @Binding var document: Document
    @State private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            HSplitView {
                PDFKitView(document: document.pdf)
                if viewModel.splitView {
                    ChatView()
                }
            }
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        Task {
                            await viewModel.summarize(document: document)
                        }
                    } label: {
                        Label(LocalizedStringKey(Localization.summarize), systemImage: Images.summarize)
                            .help(LocalizedStringKey(Localization.summarize))
                    }
                    
                    Button {
                        viewModel.splitView.toggle()
                    } label: {
                        Label(LocalizedStringKey(Localization.question), systemImage: Images.question)
                            .help(LocalizedStringKey(Localization.question))
                    }
                }
            }
        }
    }
}
