//
//  ActivityViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import Foundation
import SwiftUI

class ActivityViewModel: ObservableObject {
    @Published var questions: [Question]?
    @Published var questionIndex = 0
    
    func handleNext() {
        if let questions = questions {
            if(questionIndex + 1 >= questions.count) {
                
            } else {
                self.questionIndex += 1
            }
        }
    }
}
