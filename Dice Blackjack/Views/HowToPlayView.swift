/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Junsik Kang
  ID: 3916884
  Created  date: 08/14/2023
  Last modified: 08/19/2023
  Acknowledgement:
*/

import SwiftUI

struct HowToPlayView: View {
    // MARK: - VARIABLES
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var language: String
    @Binding var isDarkMode: Bool
    
    // MARK: - LOCALIZATION
    private let howToPlay: LocalizedStringKey = "How to play?"
    private let variation: LocalizedStringKey = "Bit a variation from Blackjack"
    private let insteadOfCards: LocalizedStringKey = "This game uses dices instead of cards. \nAlso, this game aims to sum of 24."
    private let rule: LocalizedStringKey = "Rule"
    private let dealerRolls: LocalizedStringKey = "- Dealer rolls the dices first."
    private let dependsOnDifficulty: LocalizedStringKey = "(the number of dices dealer rolls depends on the difficulty)"
    private let youRoll: LocalizedStringKey = "- You roll the dices as you wants. "
    private let ifSumAchieve: LocalizedStringKey = "- If the sum achieves 24, the round ends and you get double points."
    private let dontExceed: LocalizedStringKey = "(However, you must never exceed 24!)"
    private let stopButton: LocalizedStringKey = "- After you finish to roll, press the 'Stop' button to end your turn."
    private let dealerContinue: LocalizedStringKey = "- Dealer continues to roll."
    private let youWin: LocalizedStringKey = "(Dealer to roll unconditionally until the sum of the dices is eqaul to or greater than sum of 21. If dealer's sum of dices exceeds 24, you will win.)"
    private let compare: LocalizedStringKey = "- Compare the sum of your dices with the sum of the dealer's dices. If your sum is smaller than dealer's, you lose \n1 point. If it is greater than, you win 1 point."
    private let beatDealer: LocalizedStringKey = "- Beat the dealer by achieving the target score!"
    private let lowerHigher: LocalizedStringKey = "(The lower the total round, the higher the ranking on the leaderboard!)"
    private let gotIt: LocalizedStringKey = "Got it!"
    
    var body: some View {
        ZStack {
            // MARK: - LIGHT MODE BACKGROUND COLOR
            if(!isDarkMode) {
                LinearGradient(gradient: Gradient(colors: [Color("HowToPlayPrimaryColor"), Color("HowToPlaySecondaryColor")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            }
            VStack {
                // MARK: - LOGO & TITLE
                Group {
                    Image("dice-target")
                        .resizable()
                        .frame(width: 120, height:120)
                        .opacity(0.8)
                    if(isDarkMode) {
                        Text(howToPlay)
                            .font(.custom("Nice-Tango", size: 50))
                            .foregroundColor(.white)
                    } else {
                        Text(howToPlay)
                            .font(.custom("Nice-Tango", size: 50))
                            .foregroundColor(.black)
                    }
                }.padding(20)
                if(isDarkMode) {
                // MARK: - SHORT DESCRIPTION; DARK MODE
                GroupBox(label: Label(variation, systemImage: "info.bubble")
                    .font(.custom("KGBlankSpaceSketch", size: 21.4))
                    .foregroundColor(.white)) {
                  ScrollView(.vertical, showsIndicators: true) {
                    Text(insteadOfCards)
                      .font(.custom("KGBlankSpaceSketch", size: 18))
                      .multilineTextAlignment(.center)
                      .foregroundColor(.white)
                  }.frame(height: 60)
                }
                // MARK: - DETAIL RULES; DARK MODE
                GroupBox(label: Label(rule, systemImage: "dpad")
                    .font(.custom("KGBlankSpaceSketch", size: 21.4))
                    .foregroundColor(.white)) {
                        ScrollView(.vertical, showsIndicators: true) {
                            Group {
                                Text(dealerRolls)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                Text(dependsOnDifficulty)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }
                            Text(youRoll)
                                .font(.custom("KGBlankSpaceSketch", size: 18))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            Group {
                                Text(ifSumAchieve)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                Text(dontExceed)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }
                            Text(stopButton)
                                .font(.custom("KGBlankSpaceSketch", size: 18))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            Group {
                                Text(dealerContinue)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                Text(youWin)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }
                            Text(compare)
                                .font(.custom("KGBlankSpaceSketch", size: 18))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            Group {
                                Text(beatDealer)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                Text(lowerHigher)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }
                        }.frame(height: 200)
                    }
                } else {
                    // MARK: - SHORT DESCRIPTION; LIGHT MODE
                    GroupBox(label: Label(variation, systemImage: "info.bubble")
                        .font(.custom("KGBlankSpaceSketch", size: 21.4))
                        .foregroundColor(.black)) {
                      ScrollView(.vertical, showsIndicators: true) {
                        Text(insteadOfCards)
                          .font(.custom("KGBlankSpaceSketch", size: 18))
                          .multilineTextAlignment(.center)
                          .foregroundColor(.black)
                      }.frame(height: 60)
                    }
                    // MARK: - DETAIL RULES; LIGHT MODE
                GroupBox(label: Label(rule, systemImage: "dpad")
                    .font(.custom("KGBlankSpaceSketch", size: 21.4))
                    .foregroundColor(.black)) {
                        ScrollView(.vertical, showsIndicators: true) {
                            Group {
                                Text(dealerRolls)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                Text(dependsOnDifficulty)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                            }
                            Text(youRoll)
                                .font(.custom("KGBlankSpaceSketch", size: 18))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                            Group {
                                Text(ifSumAchieve)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                Text(dontExceed)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                            }
                            Text(stopButton)
                                .font(.custom("KGBlankSpaceSketch", size: 18))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                            Group {
                                Text(dealerContinue)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                Text(youWin)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                            }
                            Text(compare)
                                .font(.custom("KGBlankSpaceSketch", size: 18))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                            Group {
                                Text(beatDealer)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                Text(lowerHigher)
                                    .font(.custom("KGBlankSpaceSketch", size: 18))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                            }
                        }.frame(height: 200)
                    }
                }
                // MARK: - GOT IT BUTTON
                Button(action: {
                    playSound(sound: "button-click", type: "mp3")
                    playBackground(sound: "comic-sound", type: "mp3")
                    audioPlayer?.numberOfLoops = -1
                    self.presentationMode.wrappedValue.dismiss()
                })  {
                    Text(gotIt)
                }.buttonStyle(SettingButton())
            }
        }
        .environment(\.locale, .init(identifier: language))
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .onAppear(perform: { // MARK: - BACKGROUND MUSIC
            playBackground(sound: "daylight", type: "mp3")
            audioPlayer?.numberOfLoops = -1
        })
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView(language: .constant("en"), isDarkMode: .constant(true))
            //.environment(\.locale, .init(identifier: "ko"))
    }
}
