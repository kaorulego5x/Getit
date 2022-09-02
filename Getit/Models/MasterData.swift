//
//  Question.swift
//  Getit
//
//  Created by kaorulego5x on 2022/07/24.
//

import Foundation

struct MasterData: Codable {
    let words: [Word]
    let totalQuestionNum: Int
}

struct Word: Codable {
    let word: String
    let units: [Unit]
}

enum UnitType: String, Codable {
    case practical = "practical"
    case single = "single"
    case idiom = "idiom"
}

struct Unit: Codable {
    let unitId: String
    let labelIndex: Int
    let type: UnitType
}
