//
//  Tokenizer.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/8/23.
//

import Foundation

protocol Tokenizer {
    func tokenize(_ text: String) async -> [String]
}

struct BARTTokenizer: Tokenizer {
    let vocabulary: Set<String>

    init(vocabulary: Set<String>) {
        self.vocabulary = vocabulary
    }

    func tokenize(_ text: String) -> [String] {
        var tokens = [String]()

        // Normalize the text.
        let normalizedText = text.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // Handle special characters.
        let textWithSpecialCharactersHandled = normalizedText.replacingOccurrences(of: "[\\n\\t\\r]", with: " ", options: .regularExpression)

        // Split the text into words.
        let words = textWithSpecialCharactersHandled.split(separator: " ")

        // Tokenize each word.
        for word in words {
            let word = String(word)
            if vocabulary.contains(word) {
                tokens.append(word)
            } else {
                // Split the word into individual characters.
                var characters = word.map { String($0) }

                // Merge the most frequent pairs of characters until the desired vocabulary size is reached.
                var characterTokens = [String]()
                while characterTokens.count < vocabulary.count {
                    let bigram = characterTokens.last ?? "" + characters.first!
                    if vocabulary.contains(bigram) {
                        characterTokens.append(bigram)
                        characters.removeFirst()
                    } else {
                        if let first = characters.first {
                            characterTokens.append(first)
                            characters.removeFirst()
                        }
                    }
                }

                // Add the character tokens to the list of tokens.
                tokens.append(contentsOf: characterTokens)
            }
        }

        // Add the BART special tokens.
        tokens.insert(BARTTokenizer.bosToken, at: 0)
        tokens.append(BARTTokenizer.eosToken)

        return tokens
    }

    static let bosToken = "<s>"
    static let eosToken = "</s>"
    static let padToken = "<pad>"
}
