/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Junsik Kang
  ID: 3916884
  Created  date: 08/11/2023
  Last modified: 08/27/2023
  Acknowledgement: https://onmyway133.com/posts/how-to-use-button-inside-navigationlink-in-swiftui/
 https://cocoacasts.com/ud-4-how-to-store-a-dictionary-in-user-defaults-in-swift
 https://stackoverflow.com/questions/31422014/play-background-music-in-app
*/

import SwiftUI

struct ContentView: View {
    // MARK: - VARIABLES
    @EnvironmentObject var setting: Setting
    
    @State private var showingHowToPlay = false
    @State private var showingSetting = false
    @State private var enterGame = false
    
    @State var userName = "default"
    
    @State private var path: [Int] = []
    
    @State private var easyRanking : [String:[Int]] = UserDefaults.standard.object(forKey: "easyScores") as? [String:[Int]] ?? [:]
    
    @State private var hardRanking : [String:[Int]] = UserDefaults.standard.object(forKey: "hardScores") as? [String:[Int]] ?? [:]
    
    @State private var achievements : [String:String] = UserDefaults.standard.object(forKey: "achievements") as? [String:String] ?? [:]
    
    @State private var language : String = UserDefaults.standard.object(forKey: "language") as? String ?? "en"
    
    @State private var isDarkMode : Bool = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool ?? false
    
    // MARK: - LOCALIZATION
    private let enterName: LocalizedStringKey = "Enter your name!"
    private let letsGamble: LocalizedStringKey = "Let's gamble!"
    private let leaderboard: LocalizedStringKey = "Leaderboard"
    
    func clickButton() {
        playSound(sound: "button-click", type: "mp3")
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                // MARK: - LIGHT MODE BACKGROUND COLOR
                if(!isDarkMode) {
                    LinearGradient(gradient: Gradient(colors: [Color("BackgroundPrimaryColor"), Color("BackgroundSecondaryColor")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                }
                VStack(spacing: 20) {
                    // MARK: - GAME LOGO
                    if(!isDarkMode) {
                        Image("DiceBlackjackLightModeLogo")
                            .resizable()
                            .frame(width: 500, height: 550)
                            .offset(y: -30)
                    } else {
                        Image("DiceBlackjackBlackModeLogo")
                            .resizable()
                            .frame(width: 500, height: 550)
                            .offset(y: -30)
                    }
                    Spacer()
                    // MARK: - INPUT USERNAME
                    Group {
                        Text(enterName)
                            .font(.custom("Nice-Tango", size: 25))
                        TextField("default", text: $userName)
                            .font(.custom("TrebuchetMS-Bold", size: 19))
                            .padding()
                            .background(Color(uiColor: .secondarySystemBackground))
                            .frame(width: 300)
                        }.offset(y:-180)
                    Group {
                        // MARK: - GAME START BUTTON
                        Button(letsGamble) {
                            path.append(1)
                            playSound(sound: "button-click", type: "mp3")
                        }
                        .navigationDestination(for: Int.self) { int in
                            GameView(path: $path, userName: $userName, easyRanking: $easyRanking, hardRanking: $hardRanking, achievements: $achievements, language: $language, isDarkMode: $isDarkMode)
                                .environmentObject(self.setting)
                        }.buttonStyle(PlayButton())
                        // MARK: - LEADERBOARD BUTTON
                        NavigationLink {
                            LeaderboardView(easyRanking: $easyRanking, hardRanking: $hardRanking, achievements: $achievements, language: $language, isDarkMode: $isDarkMode)
                        } label: {
                            Text(leaderboard)
                        }.buttonStyle(LeaderboardButton())
                        HStack(spacing: 260) {
                            // MARK: - SETTING BUTTON
                            Button(action: {
                                self.showingSetting = true
                                playSound(sound: "button-click", type: "mp3")
                            })  {
                                Image(systemName: "gamecontroller")
                                    .foregroundColor(.white)
                                    .sheet(isPresented: $showingSetting) {
                                        SettingView(language: $language, isDarkMode: $isDarkMode)
                                            .environmentObject(self.setting)
                                    }
                            }.modifier(InfoButtonModifier())
                            // MARK: - HOWTOPLAY BUTTON
                            Button(action: {
                                self.showingHowToPlay = true
                                playSound(sound: "button-click", type: "mp3")
                            })  {
                                Image(systemName: "questionmark.app")
                                    .foregroundColor(.white)
                                    .sheet(isPresented: $showingHowToPlay) {
                                        HowToPlayView(language: $language, isDarkMode: $isDarkMode)
                                    }
                            }.modifier(InfoButtonModifier())
                        }.offset(y: 40)
                    }.offset(y: -100)
                }
            }
        } // MARK: - BACKGROUND MUSIC
        .onAppear(perform: {
            playBackground(sound: "comic-sound", type: "mp3")
            backgroundPlayer?.numberOfLoops = -1
        })
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
        .environment(\.locale, .init(identifier: language))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Setting())
            //.environment(\.locale, .init(identifier: "ko"))
    }
}
