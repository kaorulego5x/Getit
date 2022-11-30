//
//  clutterCutter.swift
//  Getit
//
//  Created by kaorulego5x on 30/11/22.
//

import Foundation

let clutters = ["...", "!?", "!!", "?!", "!", "?", ".", ","]

func getTextAndClutter(_ text: String) -> [String] {
    let textLen = text.count
    for clutter in clutters {
        let clutterLen = clutter.count
        if (text.contains(clutter)) {
            return [text.substring(to: textLen - clutterLen).lowercased(), text.substring(from: textLen - clutterLen).lowercased()]
        }
    }
    return [text.lowercased()]
}
