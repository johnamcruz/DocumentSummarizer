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
        let attentionMasks = try generateAttentionMask(inputIds: MLMultiArray.from(inputIds))
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
    
    func generateAttentionMask(inputIds: MLMultiArray) throws -> MLMultiArray {
        let attentionMaskArray = try MLMultiArray(shape: [inputIds.shape[0]], dataType: .float32)
        for index in 0..<inputIds.shape[0].intValue {
            if inputIds[index] != 0 {
                attentionMaskArray[index] = 1
            }
        }
        return attentionMaskArray
    }
}
