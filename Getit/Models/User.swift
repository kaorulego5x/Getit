//
//  User.swift
//  Getit
//
//  Created by kaorulego5x on 2022/07/24.
//

import Foundation

struct Progress: Codable {
    let learn: Int;
    let user: Int;
}

struct User: Codable {
    let progress: Progress
    let nextIndex: Int;
    let undoneUses: [String]
}
