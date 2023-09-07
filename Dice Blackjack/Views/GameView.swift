/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Junsik Kang
  ID: 3916884
  Created  date: 08/15/2023
  Last modified: 08/27/2023
  Acknowledgement: https://sarunw.com/posts/how-to-pop-to-root-view-in-swiftui/
 https://www.swiftanytime.com/blog/ultimate-guide-on-timer-in-swift
 https://www.hackingwithswift.com/read/9/4/back-to-the-main-thread-dispatchqueuemain
*/

import SwiftUI

struct GameView: View {
    // MARK: - VARIABLES
    @EnvironmentObject var setting: Setting
    
    @Binding var path: [Int]
    
    @Binding var userName: String
    @Binding var easyRanking: [String:[Int]]
    @Binding var hardRanking: [String:[Int]]
    @Binding var achievements: [String:String]
    @Binding var language: String
    @Binding var isDarkMode: Bool
    
    @State private var animatingIcon = false
    @State private var myDices = [0, 1, 2, 3, 4, 5]
    @State private var dealerFirstDices = [0, 1, 2, 3, 4, 5]
    @State private var dealerSecondDices = [0, 1, 2, 3, 4, 5]
    @State private var dealerThirdDices = [0, 1, 2, 3, 4, 5]
    @State private var dealerFourthDices = [0, 1, 2, 3, 4, 5]
    @State private var currentScore = 0
    @State private var roundCount = 1
    @State private var dealerSumOfDices = 0
    @State private var mySumOfDices = 0
    @State private var dealerDiceDisappear = false
    @State private var startButtonDisable = false
    @State private var rollButtonDisable = true
    @State private var showGameWin = false
    @State private var showGameLose = false
    @State private var beChampion = false
    @State private var isDoubleScored = false
    @State private var isRollingFinished = false
    @State private var isEasyDuplicated = false
    @State private var isHardDuplicated = false
    
    // MARK: - LOCALIZATION
    private let user: LocalizedStringKey = "User: "
    private let difficultyText: LocalizedStringKey = "Difficulty: "
    private let roundText: LocalizedStringKey = "Round: "
    private let scoreText: LocalizedStringKey = "Score: "
    private let dealerSumText: LocalizedStringKey = "Dealer's sum of dices: "
    private let yourSumText: LocalizedStringKey = "Your sum of dices: "
    private let startText: LocalizedStringKey = "Start"
    private let rollText: LocalizedStringKey = "Roll"
    private let stopText: LocalizedStringKey = "Stop"
    private let youLoseText: LocalizedStringKey = "YOU LOSE"
    private let youAreBeatenText: LocalizedStringKey = "You are beaten by dealer!\nYou are being loser :P!"
    private let nextRoundText: LocalizedStringKey = "NEXT ROUND"
    private let youWinText: LocalizedStringKey = "YOU WIN"
    private let reach24Text: LocalizedStringKey = "You've reached sum of 24!\nYou've gotten double scored :D!"
    private let youBeatText: LocalizedStringKey = "You've beaten stupid dealer!\nBe a champion :D!"
    private let youChampionText: LocalizedStringKey = "YOU ARE CHAMPION!"
    private let hereComesText: LocalizedStringKey = "Here comes our hero!\nWelcome champion!"
    private let backHomeText: LocalizedStringKey = "Back to Home"
 
    let images = ["dice-1", "dice-2", "dice-3", "dice-4", "dice-5", "dice-6"]
    
    // MARK: - GAME ROGICS
    func rollMyDices() -> Int {
        myDices = myDices.map({ _ in
            Int.random(in: 0...myDices.count - 1)
        })
        return myDices[0] + 1
    }
    
    func rollDealerFirstDices() -> Int {
        dealerFirstDices = dealerFirstDices.map({ _ in
            Int.random(in: 0...dealerFirstDices.count - 1)
        })
        return dealerFirstDices[0] + 1
    }
    
    func rollDealerSecondDices() -> Int {
        dealerSecondDices = dealerSecondDices.map({ _ in
            Int.random(in: 0...dealerSecondDices.count - 1)
        })
        return dealerSecondDices[0] + 1
    }
    
    func rollDealerThirdDices() -> Int {
        dealerThirdDices = dealerThirdDices.map({ _ in
            Int.random(in: 0...dealerThirdDices.count - 1)
        })
        return dealerThirdDices[0] + 1
    }
    
    func rollDealerFourthDices() -> Int {
        dealerFourthDices = dealerFourthDices.map({ _ in
            Int.random(in: 0...dealerFourthDices.count - 1)
        })
        return dealerFourthDices[0] + 1
    }
    
    func beChampionAchievement() {
        if(achievements["Be Champion!"] == nil) {
            achievements["Be Champion!"] = "BeChampion"
            UserDefaults.standard.set(achievements, forKey: "achievements")
        }
    }
    
    func getWinAchievement() {
        if(achievements["Get Win!"] == nil) {
            achievements["Get Win!"] = "GetWin"
            UserDefaults.standard.set(achievements, forKey: "achievements")
        }
    }
    
    func getLoseAchievement() {
        if(achievements["You Lose"] == nil) {
            achievements["You Lose"] = "GetLose"
            UserDefaults.standard.set(achievements, forKey: "achievements")
        }
    }
    
    func doubleScoredAchievement() {
        if(achievements["Doubled!"] == nil) {
            achievements["Doubled!"] = "DoubleScore"
            UserDefaults.standard.set(achievements, forKey: "achievements")
        }
    }
    
    func checkWinClickRoll() {
        mySumOfDices += self.rollMyDices()
        playSound(sound: "roll-dice", type: "mp3")
        if(mySumOfDices > 24) {
            getLoseAchievement()
            rollButtonDisable = true
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                if(self.currentScore > 0) {
                    self.currentScore -= 1
                }
                showGameLose.toggle()
            }
        } else if(mySumOfDices == 24) {
            getWinAchievement()
            doubleScoredAchievement()
            rollButtonDisable = true
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.currentScore += 2
                self.isDoubleScored.toggle()
                if(setting.difficulty == "easy") {
                    if(self.currentScore == 15 || self.currentScore == 16) {
                        beChampion.toggle()
                    } else {
                        showGameWin.toggle()
                    }
                } else {
                    if(self.currentScore == 30 || self.currentScore == 31) {
                        beChampion.toggle()
                    } else {
                        showGameWin.toggle()
                    }
                }
            }
        }
    }
    
    func checkWinClickStop() {
        if(setting.difficulty == "easy") {
            if(dealerSumOfDices > 24 || mySumOfDices >= dealerSumOfDices) {
                getWinAchievement()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.currentScore += 1
                    if(setting.difficulty == "easy") {
                        if(self.currentScore == 15) {
                            beChampion.toggle()
                        } else {
                            showGameWin.toggle()
                        }
                    } else {
                        if(self.currentScore == 30) {
                            beChampion.toggle()
                        } else {
                            showGameWin.toggle()
                        }
                    }
                }
            } else {
                getLoseAchievement()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    if(self.currentScore > 0) {
                        self.currentScore -= 1
                    }
                    showGameLose.toggle()
                }
            }
        } else {
            if(dealerSumOfDices > 24 || mySumOfDices > dealerSumOfDices) {
                getWinAchievement()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.currentScore += 1
                    if(setting.difficulty == "easy") {
                        if(self.currentScore == 15) {
                            beChampion.toggle()
                        } else {
                            showGameWin.toggle()
                        }
                    } else {
                        if(self.currentScore == 30) {
                            beChampion.toggle()
                        } else {
                            showGameWin.toggle()
                        }
                    }
                }
            } else {
                getLoseAchievement()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    if(self.currentScore > 0) {
                        self.currentScore -= 1
                    }
                    showGameLose.toggle()
                }
            }
        }
    }
    
    func addRanking() {
        if(setting.difficulty == "easy") {
            for(key, value) in easyRanking {
                if(key.lowercased() == userName.lowercased()) {
                    easyRanking[key]![1] += 1
                    UserDefaults.standard.set(easyRanking, forKey: "easyScores")
                    easyRanking[key]![2] += roundCount
                    UserDefaults.standard.set(easyRanking, forKey: "easyScores")
                    isEasyDuplicated.toggle()
                    if(roundCount < value[0]) {
                        easyRanking[key]![0] = roundCount
                        UserDefaults.standard.set(easyRanking, forKey: "easyScores")
                        break;
                    }
                }
            }
            if(!isEasyDuplicated) {
                easyRanking[userName] = [0,0,0]
                if(easyRanking[userName] != nil) {
                    easyRanking[userName]![0] = roundCount
                    UserDefaults.standard.set(easyRanking, forKey: "easyScores")
                    easyRanking[userName]![1] = 1
                    UserDefaults.standard.set(easyRanking, forKey: "easyScores")
                    easyRanking[userName]![2] = roundCount
                    UserDefaults.standard.set(easyRanking, forKey: "easyScores")
                }
            }
            isEasyDuplicated = false
            beChampionAchievement()
        } else {
            for(key, value) in hardRanking {
                if(key.lowercased() == userName.lowercased()) {
                    hardRanking[key]![1] += 1
                    UserDefaults.standard.set(hardRanking, forKey: "hardScores")
                    hardRanking[key]![2] += roundCount
                    UserDefaults.standard.set(hardRanking, forKey: "hardScores")
                    isHardDuplicated.toggle()
                    if(roundCount < value[0]) {
                        hardRanking[key]![0] = roundCount
                        UserDefaults.standard.set(hardRanking, forKey: "hardScores")
                        break;
                    }
                }
            }
            if(!isHardDuplicated) {
                hardRanking[userName] = [0,0,0]
                if hardRanking[userName] != nil {
                    hardRanking[userName]![0] = roundCount
                    UserDefaults.standard.set(hardRanking, forKey: "hardScores")
                    hardRanking[userName]![1] = 1
                    UserDefaults.standard.set(hardRanking, forKey: "hardScores")
                    hardRanking[userName]![2] = roundCount
                    UserDefaults.standard.set(hardRanking, forKey: "hardScores")
                }
            }
            isHardDuplicated = false
            beChampionAchievement()
        }
    }
    
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND COLOR
            if(!isDarkMode) {
                LinearGradient(gradient: Gradient(colors: [Color("BackgroundPrimaryColor"), Color("BackgroundSecondaryColor")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            }
            // MARK: - USERNAME & DIFFICULTY
            VStack {
                Group {
                    HStack {
                        if(!isDarkMode) {
                            Text(user)
                                .font(.custom("KGBlankSpaceSketch", size: 23))
                                .foregroundColor(.black)
                            Text("\(userName)")
                                .font(.custom("KGBlankSpaceSketch", size: 23))
                                .foregroundColor(.black)
                            Spacer()
                            Text(difficultyText)
                                .font(.custom("KGBlankSpaceSketch", size: 23))
                                .foregroundColor(.black)
                            Text("\(setting.difficulty)")
                                .font(.custom("KGBlankSpaceSketch", size: 23))
                                .foregroundColor(.black)
                        } else {
                            Text(user)
                                .font(.custom("KGBlankSpaceSketch", size: 23))
                                .foregroundColor(.white)
                            Text("\(userName)")
                                .font(.custom("KGBlankSpaceSketch", size: 23))
                                .foregroundColor(.white)
                            Spacer()
                            Text(difficultyText)
                                .font(.custom("KGBlankSpaceSketch", size: 23))
                                .foregroundColor(.white)
                            Text("\(setting.difficulty)")
                                .font(.custom("KGBlankSpaceSketch", size: 23))
                                .foregroundColor(.white)
                        }
                    }.offset(y:20)
                        .frame(width: 380)
                }
                Spacer()
                Group {
                    // MARK: - ROUND & CURRENT SCORE
                    HStack {
                        Text(roundText)
                            .font(.custom("Nice-Tango", size: 25))
                        Text("\(roundCount)")
                            .font(.custom("Nice-Tango", size: 25))
                        Spacer()
                        if(setting.difficulty == "easy") {
                            Text(scoreText)
                                .font(.custom("Nice-Tango", size: 25))
                            Text("\(currentScore)/15")
                                .font(.custom("Nice-Tango", size: 25))
                        } else {
                            Text(scoreText)
                                .font(.custom("Nice-Tango", size: 25))
                            Text("\(currentScore)/30")
                                .font(.custom("Nice-Tango", size: 25))
                        }
                    }.frame(width: 320)
                    Spacer()
                    // MARK: - DEALER'S DICES
                    HStack {
                        Text(dealerSumText)
                            .font(.custom("TrebuchetMS-Bold", size: 21))
                        Text("\(dealerSumOfDices)")
                            .font(.custom("TrebuchetMS-Bold", size: 21))
                    }
                    // MARK: - DEALER'S DICES IMAGE
                    Group {
                        HStack() {
                            if(setting.difficulty == "easy") {
                                Image(images[dealerFirstDices[0]])
                                    .resizable()
                                    .modifier(DiceImageModifier())
                                    .animation(.easeOut(duration: Double.random(in: 0.3...0.5)), value: animatingIcon)
                                    .onAppear(perform: {
                                        self.animatingIcon.toggle()
                                    })
                                if(!dealerDiceDisappear) {
                                    Image(images[dealerSecondDices[0]])
                                        .resizable()
                                        .modifier(DiceImageModifier())
                                        .animation(.easeOut(duration: Double.random(in: 0.3...0.5)), value: animatingIcon)
                                        .onAppear(perform: {
                                            self.animatingIcon.toggle()
                                        })
                                    Image(images[dealerThirdDices[0]])
                                        .resizable()
                                        .modifier(DiceImageModifier())
                                        .animation(.easeOut(duration: Double.random(in: 0.3...0.5)), value: animatingIcon)
                                        .onAppear(perform: {
                                            self.animatingIcon.toggle()
                                        })
                                    Image(images[dealerFourthDices[0]])
                                        .resizable()
                                        .modifier(DiceImageModifier())
                                        .animation(.easeOut(duration: Double.random(in: 0.3...0.5)), value: animatingIcon)
                                        .onAppear(perform: {
                                            self.animatingIcon.toggle()
                                        })
                                }
                            } else {
                                Image(images[dealerFirstDices[0]])
                                    .resizable()
                                    .modifier(DiceImageModifier())
                                    .animation(.easeOut(duration: Double.random(in: 0.3...0.5)), value: animatingIcon)
                                    .onAppear(perform: {
                                        self.animatingIcon.toggle()
                                    })
                                if(!dealerDiceDisappear) {
                                    Image(images[dealerSecondDices[0]])
                                        .resizable()
                                        .modifier(DiceImageModifier())
                                        .animation(.easeOut(duration: Double.random(in: 0.3...0.5)), value: animatingIcon)
                                        .onAppear(perform: {
                                            self.animatingIcon.toggle()
                                        })
                                    }
                                }
                            }
                        }
                    }
                Spacer()
                Group {
                    Spacer()
                    // MARK: - PLAYER'S DICE
                    HStack {
                        Text(yourSumText)
                            .font(.custom("TrebuchetMS-Bold", size: 21))
                        Text("\(mySumOfDices)")
                            .font(.custom("TrebuchetMS-Bold", size: 21))
                    }
                    // MARK: - PLAYER'S DICE IMAGE
                    Image(images[myDices[0]])
                        .resizable()
                        .modifier(DiceImageModifier())
                        .animation(.easeOut(duration: Double.random(in: 0.3...0.5)), value: animatingIcon)
                        .onAppear(perform: {
                            self.animatingIcon.toggle()
                        })
                    Spacer()
                    // MARK: - GAME START BUTTON
                    if(!startButtonDisable) {
                        Button(action: {
                            if(setting.difficulty == "easy") {
                                dealerSumOfDices += self.rollDealerFirstDices()
                                dealerSumOfDices += self.rollDealerSecondDices()
                                dealerSumOfDices += self.rollDealerThirdDices()
                                dealerSumOfDices += self.rollDealerFourthDices()
                            } else {
                                dealerSumOfDices += self.rollDealerFirstDices()
                                dealerSumOfDices += self.rollDealerSecondDices()
                            }
                            startButtonDisable.toggle()
                            rollButtonDisable.toggle()
                            playSound(sound: "roll-dice", type: "mp3")
                        }) {
                            Text(startText)
                        }.buttonStyle(RollButton())
                    }
                    // MARK: - ROLL & STOP BUTTONS
                    if(!rollButtonDisable) {
                        HStack {
                            Button(action: {
                                checkWinClickRoll()
                            }) {
                                Text(rollText)
                            }.buttonStyle(RollButton())
                            Button(action: {
                                rollButtonDisable.toggle()
                                dealerDiceDisappear.toggle()
                                if(!(dealerSumOfDices >= 21)) {
                                    _ = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { timer in
                                        playSound(sound: "roll-dice", type: "mp3")
                                        dealerSumOfDices += self.rollDealerFirstDices()
                                        if (dealerSumOfDices >= 21) {
                                            isRollingFinished = true
                                            if(isRollingFinished) {
                                                _ = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { timer in
                                                    checkWinClickStop()
                                                    isRollingFinished = false
                                                }
                                            }
                                            timer.invalidate()
                                        }
                                    }
                                } else {
                                    checkWinClickStop()
                                }
                                }) {
                                Text(stopText)
                            }.buttonStyle(RollButton())
                        }
                    }
                }.onAppear(perform: { // MARK: - BACKGROUND MUSIC
                    playBackground(sound: "game-playing", type: "mp3")
                    audioPlayer?.numberOfLoops = -1
                })
            }
            // MARK: - ROUND LOSE MODAL
            if(showGameLose) {
                ZStack{
                    VStack { // MARK: - LOSE MODAL TEXTING
                        Text(youLoseText)
                            .font(.custom("TrebuchetMS-Bold", size: 48))
                            .foregroundColor(.black)
                            .padding()
                            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                        Spacer()
                        VStack {
                            Text(youAreBeatenText)
                                .font(.custom("KGBlankSpaceSketch", size: 32))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                            Button {
                                self.showGameLose = false
                                self.roundCount += 1
                                self.mySumOfDices = 0
                                self.dealerSumOfDices = 0
                                self.startButtonDisable = false
                                self.rollButtonDisable = true
                                self.dealerDiceDisappear = false
                                } label: {
                                    Text(nextRoundText)
                                }.buttonStyle(NextroundButton())
                            }
                        Spacer()
                    }
                    .frame(width: 300, height: 350, alignment: .center)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("GameLosePrimaryColor"), Color("GameLoseSecondaryColor")]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all))
                    .cornerRadius(20)
                }.onAppear(perform: {
                    playSound(sound: "lose-game", type: "mp3")
                })
            }
            // MARK: - ROUND WIN MODAL
            if(showGameWin) {
                ZStack{
                    VStack { // MARK: - LOSE MODAL TEXTING
                        Text(youWinText)
                            .font(.custom("TrebuchetMS-Bold", size: 48))
                            .foregroundColor(.black)
                            .padding()
                            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                        Spacer()
                        VStack {
                            if(isDoubleScored) {
                                Text(reach24Text)
                                    .font(.custom("KGBlankSpaceSketch", size: 32))
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                            } else {
                                Text(youBeatText)
                                    .font(.custom("KGBlankSpaceSketch", size: 32))
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                            }
                            Spacer()
                            Button {
                                self.showGameWin = false
                                self.mySumOfDices = 0
                                self.dealerSumOfDices = 0
                                self.roundCount += 1
                                self.startButtonDisable = false
                                self.rollButtonDisable = true
                                self.dealerDiceDisappear = false
                                self.isDoubleScored = false
                                } label: {
                                    Text(nextRoundText)
                                }.buttonStyle(NextroundButton())
                            }
                        Spacer()
                    }
                    .frame(width: 300, height: 350, alignment: .center)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("GameWinPrimaryColor"), Color("GameWinSecondaryColor")]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all))
                    .cornerRadius(20)
                }.onAppear(perform: {
                    playSound(sound: "win-game", type: "mp3")
                })
            }
            // MARK: - GAME WIN SCREEN
            if(beChampion) {
                if(!isDarkMode) {
                    LinearGradient(gradient: Gradient(colors: [Color("GameWinPrimaryColor"), Color("GameWinSecondaryColor")]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                } else {
                    Color.black
                }
                ZStack {
                    VStack { // MARK: - CHAMPION TEXTING
                        if(isDarkMode) {
                            Text(youChampionText)
                                .font(.custom("TrebuchetMS-Bold", size: 48))
                                .padding()
                                .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                                .multilineTextAlignment(.center)
                                .padding(50)
                        } else {
                            Text(youChampionText)
                                .font(.custom("TrebuchetMS-Bold", size: 48))
                                .foregroundColor(.white)
                                .padding()
                                .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                                .multilineTextAlignment(.center)
                                .padding(50)
                        }
                        Spacer()
                        VStack {
                            if(isDarkMode) {
                                Text(hereComesText)
                                    .font(.custom("TrebuchetMS-Bold", size: 32))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                Spacer()
                                HStack {
                                    Text("Total Rounds:")
                                        .font(.custom("TrebuchetMS-Bold", size: 24))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                    Text(" \(roundCount)")
                                        .font(.custom("TrebuchetMS-Bold", size: 24))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                }
                            } else {
                                Text(hereComesText)
                                    .font(.custom("TrebuchetMS-Bold", size: 32))
                                    .multilineTextAlignment(.center)
                                Spacer()
                                HStack {
                                    Text("Total Rounds:")
                                        .font(.custom("TrebuchetMS-Bold", size: 24))
                                        .multilineTextAlignment(.center)
                                    Text("\(roundCount)")
                                        .font(.custom("TrebuchetMS-Bold", size: 24))
                                        .multilineTextAlignment(.center)
                                }
                            }
                            Spacer()
                            Button {
                                self.showGameWin = false
                                self.mySumOfDices = 0
                                self.dealerSumOfDices = 0
                                self.startButtonDisable = false
                                self.rollButtonDisable = true
                                self.dealerDiceDisappear = false
                                addRanking()
                                userName = "default"
                                setting.difficulty = "easy"
                                self.beChampion = false
                                path = []
                                playBackground(sound: "comic-sound", type: "mp3")
                                audioPlayer?.numberOfLoops = -1
                                } label: {
                                    Text(backHomeText)
                                }.buttonStyle(PlayButton())
                            }
                        Spacer()
                    }
                }
                .onAppear(perform: { // MARK: - BACKGROUND MUSIC
                    playBackground(sound: "champion", type: "mp3")
                })
            }
        }.navigationBarBackButtonHidden()
         .environment(\.locale, .init(identifier: language))
         .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(path: .constant([]), userName: .constant("Tony"), easyRanking: .constant([:]), hardRanking: .constant([:]), achievements: .constant([:]), language: .constant("en"), isDarkMode: .constant(false)).environmentObject(Setting())
            //.environment(\.locale, .init(identifier: "ko"))
    }
}
