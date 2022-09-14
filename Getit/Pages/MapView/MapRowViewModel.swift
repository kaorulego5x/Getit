//
//  MapRowViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/02.
//

import Foundation
import SwiftUI

class MapRowViewModel: ObservableObject {
    let eo: AppViewModel
    let progress: Progress
    let word: Word
    let completePercentage: Float
    
    init(eo: AppViewModel, progress: Progress, word: Word) {
        self.eo = eo
        self.progress = progress
        self.word = word
        self.completePercentage = 100 * Float(progress.index) / Float(word.units.count)
    }
    
    func selectUnit(_ unit: Unit) {
        eo.startUnit(unit)
    }
}
