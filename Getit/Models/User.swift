//
//  User.swift
//  Getit
//
//  Created by kaorulego5x on 2022/07/24.
//

import Foundation

struct Progress: Codable {
    let word: String
    var index: Int
}

struct User: Codable {
    let id: String
    var progress: [Progress]
    var phraseNum: Int
    var nextUp: String
}
