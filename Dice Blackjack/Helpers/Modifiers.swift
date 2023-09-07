/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Junsik Kang
  ID: 3916884
  Created  date: 08/14/2023
  Last modified: 08/17/2023
  Acknowledgement:
*/

import SwiftUI

struct InfoButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .accentColor(Color.white)
    }
}

struct ShadowModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .shadow(color:Color("ColorBlackTransparent"), radius: 7)
    }
}

struct DiceImageModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 48, idealWidth: 48, maxWidth: 60, alignment: .center)
            .modifier(ShadowModifier())
    }
}
