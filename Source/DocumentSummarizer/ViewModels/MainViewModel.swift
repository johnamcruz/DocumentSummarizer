//
//  MainViewModel.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/9/23.
//

import SwiftUI

@Observable
class MainViewModel {
    
    func summarize(document: Document) async {
        for index in 0..<document.pdf.pageCount {
            if let page = document.pdf.page(at: index) {
                if let text = page.attributedString?.string {
                    // todo: send this data to GPT for summarization
                    Task {
                        do {
                            _ = try await SummarizationService().summarize(input: text)
                        }
                        catch {
                            print("error loading \(error)")
                        }
                    }
                }
            }
        }
    }
}

