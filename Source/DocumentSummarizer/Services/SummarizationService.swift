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
    case resourceFileMissing
}

protocol SummarizationServiceable {
    func summarize(input: String) async throws -> String
}

class SummarizationService: SummarizationServiceable {
    
    func summarize(input: String) async throws -> String {
        guard let vocabUrl = Bundle.main.url(forResource: "vocab", withExtension: "json"),
              let mergesUrl = Bundle.main.url(forResource: "merges", withExtension: "txt") else {
            throw SummarizationError.resourceFileMissing
        }
        let config = TokenizerConfig(vocab: vocabUrl, merges: mergesUrl)
        let tokenizer = Tokenizer(config: config)
        let encoded = tokenizer.encode(text: input)
        let input_ids = tokenizer.appendEOS(tokens: tokenizer.appendBOS(tokens: encoded))
        print(input_ids)
        /*let model = try float32_model()
        let attentionMasks = encoded.map{ _ in 1 }
        let result = try await model.prediction(input: float32_modelInput(input_ids: MLMultiArray.from(encoded),
                                                   attention_mask: MLMultiArray.from(attentionMasks)))*/
        //let model = try LanguageModel.loadCompiled(url: URL)
        //let output = try await model.prediction(input: modelInput)
       // return tokenizer.decode(tokens: output.logits.toIntArray())
        return input
    }
}
