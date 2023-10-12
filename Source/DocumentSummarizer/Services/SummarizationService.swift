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
    let tokenizer: Tokenizer
    
    init() throws {
        guard let vocabUrl = Bundle.main.url(forResource: "vocab", withExtension: "json"),
              let mergesUrl = Bundle.main.url(forResource: "merges", withExtension: "txt") else {
            throw SummarizationError.resourceFileMissing
        }
        let config = TokenizerConfig(vocab: vocabUrl, merges: mergesUrl)
        self.tokenizer = Tokenizer(config: config)
    }
    
    func summarize(input: String) async throws -> String {
        let inputIds = try generateInputIds(input: input)
        let encoderModel = try BARTencoderModel()
        let attentionMasks = try generateAttentionMask(inputIds: inputIds)
        let inputParameter = BARTencoderModelInput(input_ids: attentionMasks,
                                                   attention_mask: attentionMasks)
        let output = try await encoderModel.prediction(input: inputParameter)
        let result = decodeOutput(output: output.last_hidden_state.toIntArray())
        return result
    }
    
    func generateInputIds(input: String) throws -> [Int] {
        let encoded = tokenizer.encode(text: input)
        return tokenizer.appendEOS(tokens: tokenizer.appendBOS(tokens: encoded))
    }
    
    func decodeOutput(output: [Int])-> String {
        return tokenizer.decode(tokens: tokenizer.stripBOS(tokens: tokenizer.stripEOS(tokens: output)))
    }
    
    func generateAttentionMask(inputIds: [Int]) throws -> MLMultiArray {
        let attentionMask = try MLMultiArray(shape: [1, NSNumber(integerLiteral: inputIds.count)], dataType: .float32)
        
        // Iterate over the input_ids and set the corresponding values in the MLMultiArray to 1.0.
        for index in 0..<inputIds.count {
            attentionMask[index] = inputIds[index] == 0 ?  0.0 : 1.0
        }
        return attentionMask
    }
}
