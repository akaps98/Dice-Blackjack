/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Junsik Kang
  ID: 3916884
  Created  date: 08/18/2023
  Last modified: 08/18/2023
  Acknowledgement: https://stackoverflow.com/questions/60898944/a-view-environmentobject-for-may-be-missing-as-an-ancestor-of-this-view
*/

import SwiftUI

struct MainView: View {
  @State var setting = Setting()
    
  var body: some View {
    ContentView().environmentObject(setting)
  }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(Setting())
    }
}
