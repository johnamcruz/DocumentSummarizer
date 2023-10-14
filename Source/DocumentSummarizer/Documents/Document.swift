//
//  DocumentSummarizerDocument.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/6/23.
//

import SwiftUI
import UniformTypeIdentifiers
import PDFKit

struct Document: FileDocument {
    static let docxUType = UTType(filenameExtension: "docx")!
    
    var pdf: PDFDocument

    init(pdf: PDFDocument) {
        self.pdf = pdf
    }

    // todo: document support for pdf, epub and docx
    static var readableContentTypes: [UTType] { [.pdf, .epub, docxUType] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let pdf = PDFDocument(data: data)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.pdf = pdf
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = pdf.dataRepresentation()!
        return .init(regularFileWithContents: data)
    }
}
