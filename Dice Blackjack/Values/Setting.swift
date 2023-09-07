/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Junsik Kang
  ID: 3916884
  Created  date: 08/16/2023
  Last modified: 08/26/2023
  Acknowledgement: https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
*/

import Foundation
import SwiftUI
import Combine

class Setting: ObservableObject {
    @Published var difficulty = "easy" // default value
}
