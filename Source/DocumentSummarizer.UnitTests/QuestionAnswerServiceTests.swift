//
//  QuestionAnswerServiceTests.swift
//  DocumentSummarizer.UnitTests
//
//  Created by John M Cruz on 10/10/23.
//

import XCTest
@testable import DocumentSummarizer

final class QuestionAnswerServiceTests: XCTestCase {
    let questionAnswerService = QuestionAnswerService()

    func testQuestion() async throws {
        _ = try await questionAnswerService.question(input: "test", question: "test")
    }
}
