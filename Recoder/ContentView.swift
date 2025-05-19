//
//  ContentView.swift
//  Recoder
//
//  Created by Sudarshini Venugopal on 19/05/25.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    let speechRecognizer = SpeechRecognizer()
    @State private var words = ""
    var recordingClass = RecordSettings()
    @State private var recordTitle = "Record"
    var body: some View {
        VStack {
            Button(recordTitle) {
                if(recordTitle == "Record"){
                    recordingClass.startRecording()
                    recordTitle = "Stop recording"
                }else{
                    recordingClass.stopRecording()
                    recordTitle = "Record"
                    speechRecognizer.transcribe { text in
                        DispatchQueue.main.async {
                            self.words = text ?? "Transcription failed"
                        }
                    }
                }
                
            }
            Spacer()
            Text($words.wrappedValue)
            Spacer()
            Button("Play") {
                recordingClass.playRecording()
            }
        }
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
