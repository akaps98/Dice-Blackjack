/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Junsik Kang
  ID: 3916884
  Created  date: 08/19/2023
  Last modified: 08/19/2023
  Acknowledgement:
*/

import AVFoundation

var backgroundPlayer: AVAudioPlayer?

func playBackground(sound: String, type: String) {
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
        backgroundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        backgroundPlayer?.play()
    } catch {
      print("ERROR: Could not find and play the sound file!")
    }
  }
}
