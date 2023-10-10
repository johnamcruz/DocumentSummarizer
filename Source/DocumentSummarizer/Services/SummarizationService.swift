//
//  SummarizationService.swift
//  DocumentSummarizer
//
//  Created by John M Cruz on 10/7/23.
//

import Foundation
import CoreML
import Tokenizers
import Models

enum SummarizationError: Error {
    case invalidLanguageModel
}

protocol SummarizationService {
    func summarize(input: String) async throws -> String
}

class Llama2SummarizationService: SummarizationService {
    
    func summarize(input: String) async throws -> String {
        /*let tokenizer = try await AutoTokenizer.from(pretrained: "bert-base-uncased")
        let model = try LanguageModel.loadCompiled(url: URL(filePath: ""))
        let output = try await model.prediction(input: modelInput)
        return tokenizer.decode(tokens: output.logits.toIntArray())*/
        print(input)
        return input
    }
}
