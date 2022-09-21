//
//  MasterData.swift
//  Getit
//
//  Created by kaorulego5x on 2022/07/24.
//

import Foundation

struct MasterData: Codable {
    let words: [Word]
    let totalPhraseNum: Int
}

struct Word: Codable, Hashable {
    let word: String
    let units: [Unit]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(word)
    }
    
    static func ==(lhs: Word, rhs: Word) -> Bool {
        return lhs.word == rhs.word
    }
}

enum UnitType: String, Codable {
    case practical = "practical"
    case single = "single"
    case idiom = "idiom"
}

struct Unit: Codable, Hashable {
    let unitId: String
    let labelIndex: Int
    let type: UnitType
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(unitId)
    }
    
    static func ==(lhs: Unit, rhs: Unit) -> Bool {
        return lhs.unitId == rhs.unitId
    }
}
