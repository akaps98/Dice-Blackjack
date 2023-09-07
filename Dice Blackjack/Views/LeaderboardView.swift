/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Junsik Kang
  ID: 3916884
  Created  date: 08/15/2023
  Last modified: 08/27/2023
  Acknowledgement: https://stackoverflow.com/questions/56675532/swiftui-iterating-through-dictionary-with-foreach
https://stackoverflow.com/questions/56893240/is-there-any-way-to-make-a-paged-scrollview-in-swiftui
*/

import SwiftUI

struct LeaderboardView: View {
    // MARK: - VARIABLES
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var easyRanking: [String:[Int]]
    @Binding var hardRanking: [String:[Int]]
    @Binding var achievements: [String:String]
    @Binding var language: String
    @Binding var isDarkMode: Bool
    
    // MARK: - LOCALIZATION
    private let leaderboard: LocalizedStringKey = "Leaderboard"
    private let bestRounds: LocalizedStringKey = "Best rounds:"
    private let totalGames: LocalizedStringKey = "Total Games:"
    private let totalRounds: LocalizedStringKey = "Total Rounds:"
    private let achievementsText: LocalizedStringKey = "Achievements"
    
    var body: some View {
        // MARK: - 3 DIFFERENT LEADER BOARD
        return GeometryReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ZStack { // MARK: - EASY DIffICULTY LEADERBOARD
                        LinearGradient(gradient: Gradient(colors: [Color("SettingPrimaryColor"), Color("SettingSecondaryColor")]), startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all)
                        VStack {
                            Group { // MARK: - TITLE
                                Text(leaderboard)
                                    .font(.custom("Nice-Tango", size: 50))
                                    .foregroundColor(.white)
                                Text("Easy")
                                    .font(.custom("Nice-Tango", size: 30))
                                    .foregroundColor(.black)
                            }.offset(y:65)
                            List {
                                ForEach(easyRanking.sorted(by: {$0.value[0] < $1.value[0]}), id: \.key) {
                                    key, value in
                                    VStack {
                                        HStack { // MARK: - USERNAME
                                            Text("\(key)")
                                                .font(.custom("KGBlankSpaceSketch", size: 19))
                                                .foregroundColor(.cyan)
                                            Spacer()
                                            // MARK: - BEST ROUND
                                            Text(bestRounds)
                                                .font(.custom("KGBlankSpaceSketch", size: 17))
                                            Text("\(value[0])")
                                                .font(.custom("KGBlankSpaceSketch", size: 17))
                                        }
                                        HStack { // MARK: - TOTAL GAMES
                                            Text(totalGames)
                                                .font(.custom("KGBlankSpaceSketch", size: 12))
                                            Text("\(value[1])")
                                                .font(.custom("KGBlankSpaceSketch", size: 12))
                                            Spacer()
                                            // MARK: - TOTAL ROUNDS
                                            Text("Total Rounds:")
                                                .font(.custom("KGBlankSpaceSketch", size: 12))
                                            Text("\(value[2])")
                                                .font(.custom("KGBlankSpaceSketch", size: 12))
                                        }
                                    }
                                }
                            }.offset(y:70)
                        }
                    }.frame(width: proxy.size.width, height: proxy.size.height)
                    ZStack { // MARK: - HARD DIffICULTY LEADERBOARD
                        LinearGradient(gradient: Gradient(colors: [Color("HowToPlayPrimaryColor"), Color("HowToPlaySecondaryColor")]), startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all)
                        VStack {
                            Group { // MARK: - TITLE
                                Text(leaderboard)
                                    .font(.custom("Nice-Tango", size: 50))
                                    .foregroundColor(.white)
                                Text("Hard")
                                    .font(.custom("Nice-Tango", size: 30))
                                    .foregroundColor(.black)
                            }.offset(y:65)
                            List {
                                ForEach(hardRanking.sorted(by: {$0.value[0] < $1.value[0]}), id: \.key) {
                                    key, value in
                                    VStack {
                                        HStack { // MARK: - BEST ROUND
                                            Text("\(key)")
                                                .font(.custom("KGBlankSpaceSketch", size: 19))
                                                .foregroundColor(.cyan)
                                            Spacer()
                                            Text(bestRounds)
                                                .font(.custom("KGBlankSpaceSketch", size: 17))
                                            Text("\(value[0])")
                                                .font(.custom("KGBlankSpaceSketch", size: 17))
                                        }
                                        HStack { // MARK: - TOTAL GAMES
                                            Text(totalGames)
                                                .font(.custom("KGBlankSpaceSketch", size: 12))
                                            Text("\(value[1])")
                                                .font(.custom("KGBlankSpaceSketch", size: 12))
                                            Spacer()
                                            // MARK: - TOTAL ROUNDS
                                            Text("Total Rounds:")
                                                .font(.custom("KGBlankSpaceSketch", size: 12))
                                            Text("\(value[2])")
                                                .font(.custom("KGBlankSpaceSketch", size: 12))
                                        }
                                    }
                                }
                            }.offset(y:70)
                        }
                    }.frame(width: proxy.size.width, height: proxy.size.height)
                    ZStack { // MARK: - ACHIEVEMENT LEADERBOARD
                        LinearGradient(gradient: Gradient(colors: [Color("GameLosePrimaryColor"), Color("GameLoseSecondaryColor")]), startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all)
                        VStack {
                            Group {
                                Text(achievementsText)
                                    .font(.custom("Nice-Tango", size: 50))
                                    .foregroundColor(.white)
                            }.offset(y:65)
                            List {
                                ForEach(achievements.sorted(by: <), id: \.key) {
                                    key, value in
                                    HStack() {
                                        Spacer()
                                        VStack(spacing: 15) {
                                            // MARK: - ACHIEVEMENT TITLE
                                            Text("\(key)")
                                                .font(.custom("KGBlankSpaceSketch", size: 19))
                                                .foregroundColor(.cyan)
                                                .offset(x:-60)
                                            // MARK: - CHECKMARK
                                            Image(systemName: "checkmark.circle.fill")
                                                .imageScale(.large)
                                                .foregroundColor(.green)
                                                .offset(x:-60)
                                        }
                                        Spacer()
                                        // MARK: - ACHIEVEMENT SYMBOL
                                        Image("\(value)")
                                            .resizable()
                                            .frame(width: 90, height: 90)
                                            .offset(x:-40)
                                    }.frame(height: 100)
                                }
                            }.preferredColorScheme(isDarkMode ? .dark : .light)
                            .offset(y:70)
                        }
                    }.frame(width: proxy.size.width, height: proxy.size.height)
                }
            }
        }
        .environment(\.locale, .init(identifier: language))
        .onAppear {
            UIScrollView.appearance().isPagingEnabled = true
        }.edgesIgnoringSafeArea(.all)
//            .navigationBarBackButtonHidden()
        .onAppear(perform: { // MARK: - BACKGROUND MUSIC
            playBackground(sound: "happy-days", type: "mp3")
            audioPlayer?.numberOfLoops = -1
        })
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView(easyRanking: .constant(["Tony":[20, 5, 62], "Henry":[21, 4, 30], "Julie": [18, 3, 20]]), hardRanking: .constant(["danny":[30,6,80], "song": [40,8,102]]),achievements: .constant(["Get win!": "GetWin", "Be Champion!":"BeChampion"]), language: .constant("en"), isDarkMode: .constant(true))
            //.environment(\.locale, .init(identifier: "ko"))
    }
}

