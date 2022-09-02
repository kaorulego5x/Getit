//
//  User.swift
//  Getit
//
//  Created by kaorulego5x on 2022/07/24.
//

import Foundation

struct Progress: Codable {
    let word: String
    let index: Int
}

struct User: Codable {
    let id: String
    let progress: [Progress]
    let questionNum: Int
}
