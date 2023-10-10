//
//  PDFView.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/6/23.
//

import SwiftUI
import PDFKit

#if os(macOS)
struct PDFKitView: NSViewRepresentable {
    let document: PDFDocument
    
    func makeNSView(context: Context) -> some NSView {
        let pdfView = PDFView()
        pdfView.document = document
        return pdfView
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        
    }
}
#else
struct PDFKitView: UIViewRepresentable {
    let document: PDFDocument
    
    func makeUIView(context: Context) -> some UIView {
        let pdfView = PDFView()
        pdfView.document = document
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
#endif
