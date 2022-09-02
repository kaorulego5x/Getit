//
//  QuestionViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import Foundation
import SwiftUI

class QuestionViewModel: ObservableObject {
    var seconds = 0.0
    var timer = Timer()
    @Published var secondsElapsed = 0.0
    @Published var isAnswerVisible = false
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if(self.seconds >= 4.9) {
                timer.invalidate()
                self.showAnswer()
                return
            }
            self.seconds += 0.05
            self.secondsElapsed += 0.05
            
        }
    }
    
    func showAnswer() {
        withAnimation(.easeOut(duration: 0.1)){
            self.isAnswerVisible = true
        }
    }
}
