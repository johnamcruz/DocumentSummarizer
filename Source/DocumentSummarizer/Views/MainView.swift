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
            PDFKitView(document: document.pdf)
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
                            
                        } label: {
                            Label(LocalizedStringKey(Localization.question), systemImage: Images.question)
                                .help(LocalizedStringKey(Localization.question))
                        }
                    }
                }
        }
    }
}
