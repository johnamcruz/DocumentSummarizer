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

protocol SummarizationServiceable {
    func summarize(input: String) async throws -> String
}

class SummarizationService: SummarizationServiceable {
    
    func summarize(input: String) async throws -> String {
        /*let tokenizer = try await AutoTokenizer.from(pretrained: "johnamcruz/mobilebert-uncased-coreml")
        let encoded = tokenizer.encode(text: input)
        let model = try float32_model()
        let attentionMasks = encoded.map{ _ in 1 }
        let result = try await model.prediction(input: float32_modelInput(input_ids: MLMultiArray.from(encoded),
                                                   attention_mask: MLMultiArray.from(attentionMasks)))*/
        //let model = try LanguageModel.loadCompiled(url: URL)
        //let output = try await model.prediction(input: modelInput)
       // return tokenizer.decode(tokens: output.logits.toIntArray())
        print(input)
        return input
    }
}
