//
//  DocumentSummarizerApp.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/6/23.
//

import SwiftUI
import PDFKit

@main
struct DocumentSummarizerApp: App {
    var body: some Scene {
        DocumentGroup(viewing: Document.self) { file in
            MainView(document: file.$document)
        }
    }
}
