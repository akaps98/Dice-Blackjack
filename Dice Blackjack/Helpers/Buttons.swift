/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Junsik Kang
  ID: 3916884
  Created  date: 08/15/2023
  Last modified: 08/17/2023
  Acknowledgement:
*/

import SwiftUI

struct PlayButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("TrebuchetMS-Bold", size: 22))
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
}

struct LeaderboardButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("TrebuchetMS-Bold", size: 22))
            .padding()
            .background(Color(red: 0.5, green: 0, blue: 0))
            .foregroundStyle(.black)
            .clipShape(Capsule())
    }
}

struct SettingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Nice-Tango", size: 23))
            .foregroundColor(.white)
            .padding()
            .background(Color(red: 0, green: 0.5, blue: 0))
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
}

struct RollButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("KGBlankSpaceSketch", size: 22))
            .padding()
            .background(Color(red: 0.5, green: 0.5, blue: 0))
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
}

struct NextroundButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("TrebuchetMS-Bold", size: 22))
            .padding()
            .background(Color(red: 0.5, green: 0.5, blue: 0.5))
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
}
