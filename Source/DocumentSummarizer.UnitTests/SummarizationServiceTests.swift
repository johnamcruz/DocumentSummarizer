//
//  DocumentSummarizer_UnitTests.swift
//  DocumentSummarizer.UnitTests
//
//  Created by John M Cruz on 10/8/23.
//

import XCTest
@testable import DocumentSummarizer

final class SummarizationServiceTests : XCTestCase {
    let summarizer = SummarizationService()

    func testSummarize() async throws {
        let result = try await summarizer.summarize(input: "test")
        XCTAssertEqual("test", result)
    }
}
