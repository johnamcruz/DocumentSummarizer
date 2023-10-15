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
    case invalidResult
}

protocol SummarizationServiceable {
    func summarize(input: String) async throws -> String
}
/*
 **High-level algorithm for BART summarization using Hugging Face encoder and decoder:**

 1. **Load the encoder and decoder:**
 ```
 from transformers import BartEncoder, BartDecoder, AutoModelForSeq2SeqLM

 bart_encoder = BartEncoder.from_pretrained("facebook/bart-base")
 bart_decoder = BartDecoder.from_pretrained("facebook/bart-base")
 # or
 bart_model = AutoModelForSeq2SeqLM.from_pretrained("facebook/bart-base")
 ```

 2. **Encode the input text:**
 ```
 input_ids = bart_encoder.encode(input_text)
 ```

 3. **Generate the summary:**
 ```
 # If using the Hugging Face AutoModelForSeq2SeqLM:
 summary_ids = bart_model.generate(
     input_ids=input_ids,
     max_length=summary_length,
 )

 # If using the Hugging Face BartEncoder and BartDecoder:
 summary_ids = bart_decoder.generate(
     encoder_outputs=bart_encoder.predict(input_ids),
     max_length=summary_length,
 )
 ```

 4. **Decode the summary:**
 ```
 summary_text = bart_encoder.decode(summary_ids)
 ```

 5. **Return the summary:**
 ```
 return summary_text
 ```

 **Additional notes:**

 * You can adjust the `summary_length` parameter to control the length of the summary.
 * You can also use beam search to generate more diverse summaries. To do this, set the `num_beams` parameter to a value greater than 1.
 * If you are using the Hugging Face AutoModelForSeq2SeqLM, you can also use the `eos_token_id` parameter to specify the end-of-sequence token. This is useful if you want to generate summaries that are a specific length.
 */
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
        print(encoderModel.model.modelDescription)
        let attentionMasks = try MLMultiArray(shape: [1,128], dataType: .int32)
        let inputParameter = BARTencoderModelInput(input_ids: try inputIds.toMultiArray(),
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
}

extension [Int] {
    func toMultiArray() throws -> MLMultiArray {
        let inputArray = try MLMultiArray(shape: [1, 128], dataType: .float32)

        for i in 0..<self.count {
            inputArray[i] = NSNumber(floatLiteral: Double(self[i]))
        }

        for i in self.count..<128 {
            inputArray[i] = NSNumber(floatLiteral: 0.0)
        }

        return inputArray
    }
}
