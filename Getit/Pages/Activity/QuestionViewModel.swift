//
//  QuestionViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import Foundation
import SwiftUI

class QuestionViewModel: ObservableObject {
    var handleNext: (Bool) -> Void
    
    
    
    init(_ handleNext: @escaping (Bool) -> Void) {
        self.handleNext = handleNext
    }

    
    func handleInCorrect() {
        self.handleNext(false)
    }
    
    func handleCorrect() {
        self.handleNext(true)
    }
}
