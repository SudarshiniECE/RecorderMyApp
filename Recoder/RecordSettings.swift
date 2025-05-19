//
//  RecordSettings.swift
//  Recoder
//
//  Created by Sudarshini Venugopal on 19/05/25.
//

import Foundation
import AVFoundation
class RecordSettings{
    var audioPlayer: AVAudioPlayer?
    func requestRecordPermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if granted {
                // Permission granted
            } else {
                // Handle permission denied
            }
        }
    }
    func setupAudioSession() throws {
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .default)
        try audioSession.setActive(true)
    }
    
    var audioRecorder: AVAudioRecorder?

    func setupRecorder() throws {
        let recordingSettings = [AVFormatIDKey: kAudioFormatMPEG4AAC, AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue] as [String : Any]
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("recording.m4a")
        
        audioRecorder = try AVAudioRecorder(url: audioFilename, settings: recordingSettings)
        audioRecorder?.prepareToRecord()
    }
    func startRecording() {
        do{
            try setupAudioSession()
            try setupRecorder()
            audioRecorder?.record()
            print("Recording started")
        }catch{
            print("Failed to start recording: \(error)")
        }
        audioRecorder?.record()
        print("recorded")
    }

    func stopRecording() {
        audioRecorder?.stop()
    }
    func playRecording() {
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("recording.m4a")

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer?.play()
            print("Playback started")
        } catch {
            print("Playback failed: \(error)")
        }
    }
}
