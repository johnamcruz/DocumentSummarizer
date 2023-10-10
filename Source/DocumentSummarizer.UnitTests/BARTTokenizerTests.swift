//
//  DocumentSummarizer_UnitTests.swift
//  DocumentSummarizer.UnitTests
//
//  Created by John M Cruz on 10/8/23.
//

import XCTest
@testable import DocumentSummarizer

final class BARTTokenizerTests : XCTestCase {
    let tokenizer = BARTTokenizer(vocabulary: Set(["this", "is", "a", "sample", "text", "sequence"]))

    func testTokenize() async throws {
        // Tokenize a sentence with special characters.
        var tokens = tokenizer.tokenize("This is a sample text sequence with a special character: %.")
        XCTAssertEqual(tokens, ["<s>", "this", "is", "a", "sample", "text", "sequence", "with", "a", "special", "character", ":", "%", ".", "</s>"])

        // Tokenize a rare word.
        tokens = tokenizer.tokenize("antidisestablishmentarianism")
        XCTAssertEqual(tokens, ["<s>", "an", "ti", "di", "se", "ta", "bl", "is", "h", "me", "nt", "ar", "ia", "ni", "sm", "</s>"])
        print(tokens) //

        // Tokenize a long sentence.
        tokens = tokenizer.tokenize("This is a very long sentence with many words and special characters. It is a good example of a sentence that can be tokenized by the BARTTokenizer function.")
        XCTAssertEqual(tokens, ["<s>", "this", "is", "a", "very", "long", "sentence", "with", "many", "words", "and", "special", "characters", "it", "is", "a", "good", "example", "of", "a", "sentence", "that", "can", "be", "tokenized", "by", "the", "barttokenizer", "function", "</s>"])
    }
}
