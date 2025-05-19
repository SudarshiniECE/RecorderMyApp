//
//  SpeechConverter.swift
//  Recoder
//
//  Created by Sudarshini Venugopal on 19/05/25.
//

import Foundation
import Speech

class SpeechRecognizer {
    let recognizer = SFSpeechRecognizer()
    let request = SFSpeechURLRecognitionRequest(url: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("recording.m4a"))

    func transcribe(completion: @escaping (String?) -> Void) {
        recognizer?.recognitionTask(with: request) { result, error in
            if let result = result {
                if result.isFinal {
                    completion(result.bestTranscription.formattedString)
                }
            } else if let error = error {
                print("Transcription error: \(error)")
                completion(nil)
            }
        }
    }
}
