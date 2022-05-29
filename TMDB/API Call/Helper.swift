//
//  Helper.swift
//  TMDB
//
//  Created by George Joseph Kristian on 26/05/22.
//

import SwiftUI
import Foundation

var apiKey: String = "5dc3098fdb937b7ddd22c3cddabc3751"

enum StateAPI {
    case done
    case loading
    case initial
    case error
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
