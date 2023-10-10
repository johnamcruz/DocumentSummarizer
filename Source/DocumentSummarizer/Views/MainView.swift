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
    
    var body: some View {
        NavigationStack {
            PDFKitView(document: document.pdf)
                .toolbar {
                    Button {
                        Task {
                            for index in 0..<document.pdf.pageCount {
                                if let page = document.pdf.page(at: index) {
                                    if let text = page.attributedString?.string {
                                        // todo: send this data to GPT for summarization
                                        Task {
                                            do {
                                                _ = try await Llama2SummarizationService().summarize(input: text)
                                            }
                                            catch {
                                                print("error loading \(error)")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } label: {
                        Label(LocalizedStringKey(Localization.summarize), systemImage: Images.summarize)
                            .help(LocalizedStringKey(Localization.summarize))
                    }
                }
        }
    }
}
