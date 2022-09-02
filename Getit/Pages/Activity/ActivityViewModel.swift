//
//  ActivityViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import Foundation
import SwiftUI

class ActivityViewModel: ObservableObject {
    let questions: [Question]
    @Published var questionIndex = 0
    
    init(questions: [Question]){
        self.questions = questions
    }
    
    func handleNext() {
        if(questionIndex + 1 >= questions.count) {
            
        } else {
            self.questionIndex += 1
        }
    }
}