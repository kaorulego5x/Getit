//
//  Question.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import Foundation

struct Question: Codable {
    let unitId: String
    let en: String
    let ja: String
    let idiom: Idiom?
}

struct Idiom: Codable {
    let en: String
    let ja: String
}
