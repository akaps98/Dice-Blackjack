/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Junsik Kang
  ID: 3916884
  Created  date: 08/15/2023
  Last modified: 08/20/2023
  Acknowledgement:
*/

import SwiftUI

struct SettingView: View {
    // MARK: - VARIABLES
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var setting: Setting
    
    @Binding var language: String
    @Binding var isDarkMode: Bool
    
    var lang = ["Korean", "English"]
    
    // MARK: - LOCALIZATION
    private let chooseDiff: LocalizedStringKey = "Choose the difficulty you want!"
    private let easyExplain: LocalizedStringKey = "Easy: The target score is 15 points!\nYou can see the four dice on the dealer before rolling the dice.\nYou will earn score if you \ndraw with a dealer!"
    private let hardExplain: LocalizedStringKey = "Hard: The target score is 30 points!\nYou can see only two dice on the dealer before rolling the dice!\nYou will lose score if you \ndraw with a dealer!"
    private let easy: LocalizedStringKey = "Easy"
    private let hard: LocalizedStringKey = "Hard"
    private let chooseLang: LocalizedStringKey = "Choose the language!"
    
    var body: some View {
        ZStack {
            // MARK: - LIGHT MODE BACKGROUND COLOR
            if(!isDarkMode) {
                LinearGradient(gradient: Gradient(colors: [Color("SettingPrimaryColor"), Color("SettingSecondaryColor")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            }
            // MARK: - TOGGLE DARK/LIGHT MODE
            VStack(spacing: 40) {
                Button(action: {isDarkMode.toggle()}, label: {
                    isDarkMode ? Label("", systemImage: "sun.max") : Label("", systemImage: "moon.fill")
                })
                // MARK: - EXPLANATION ABOUT DIFFICULTIES
                Text(chooseDiff)
                    .font(.custom("KGBlankSpaceSketch", size: 24))
                    .foregroundColor(.white)
                if(isDarkMode) {
                    Text(easyExplain)
                        .font(.custom("Nice-Tango", size: 24))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Text(hardExplain)
                        .font(.custom("Nice-Tango", size: 24))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                } else {
                    Text(easyExplain)
                        .font(.custom("Nice-Tango", size: 24))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    Text(hardExplain)
                        .font(.custom("Nice-Tango", size: 24))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
                HStack(spacing: 70) {
                    // MARK: - EASY BUTTON
                    Button(action: {
                        playSound(sound: "button-click", type: "mp3")
                        self.setting.difficulty = "easy"
                        self.presentationMode.wrappedValue.dismiss()
                    })  {
                        Text(easy)
                    }.buttonStyle(SettingButton())
                    // MARK: - HARD BUTTON
                    Button(action: {
                        playSound(sound: "button-click", type: "mp3")
                        self.setting.difficulty = "hard"
                        self.presentationMode.wrappedValue.dismiss()
                    })  {
                        Text(hard)
                    }.buttonStyle(SettingButton())
                }.offset(y: 10)
                VStack {
                    Text(chooseLang)
                        .font(.custom("KGBlankSpaceSketch", size: 24))
                        .foregroundColor(.white)
                    Picker("Choose language", selection: $language) {
                        ForEach(lang, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                        .padding()
                        .background(.yellow)
                        .cornerRadius(15)
                        .padding()
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .scrollContentBackground(.hidden)
        .environment(\.locale, .init(identifier: language))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(language: .constant("en"), isDarkMode: .constant((true))).environmentObject(Setting())
            .environment(\.locale, .init(identifier: "en"))
    }
}
