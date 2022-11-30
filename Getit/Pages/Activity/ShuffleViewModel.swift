//
//  ShuffleViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 30/11/22.
//

import SwiftUI
import Foundation

struct ShuffleCandidate {
    var text: String
    var position: Int
}

struct ShuffleBlank {
    var isBlank: Bool
    var answerIndex: Int
    var placeHolder: String
}

enum ShuffleStatus: String {
    case selecting = "selecting"
    case correct = "correct"
    case incorrect = "incorrect"
}

class ShuffleViewModel: ObservableObject {
    @Published var blanks: [ShuffleBlank] =  []
    @Published var answers: [String] = []
    @Published var candidates: [ShuffleCandidate] = []
    @Published var selectedCandidates: [ShuffleCandidate] = []
    @Published var shuffleStatus: ShuffleStatus = ShuffleStatus.selecting
    
    func reset(_ session: Session) {
        self.blanks = []
        self.answers = []
        self.candidates = []
        self.selectedCandidates = []
        self.shuffleStatus = .selecting
        
        var answerIndex = 0
        for component in session.phrase.en.components(separatedBy: " ") {
            let textAndClutter = getTextAndClutter(component)
            if (textAndClutter.count == 2) {
                self.blanks.append(ShuffleBlank(isBlank: true, answerIndex: answerIndex, placeHolder: ""))
                answerIndex += 1
                self.blanks.append(ShuffleBlank(isBlank: false, answerIndex: 0, placeHolder: textAndClutter[1]))
                self.answers.append(textAndClutter[0])
            } else if (textAndClutter[0] == "-") {
                self.blanks.append(ShuffleBlank(isBlank: false, answerIndex: 0, placeHolder: "-"))
            } else {
                self.blanks.append(ShuffleBlank(isBlank: true, answerIndex: answerIndex, placeHolder: ""))
                answerIndex += 1
                self.answers.append(textAndClutter[0])
            }
        }
        self.candidates = self.answers.shuffled().enumerated().map { (index, answer) in
            return ShuffleCandidate(text: answer, position: index)
        }
    }
    
    func selectShuffleCandidate(_ candidate: ShuffleCandidate) {
        self.selectedCandidates.append(candidate)
    }
    
    func unselectShuffleCandidate(_ candidate: ShuffleCandidate) {
        let index = self.selectedCandidates.firstIndex(where: {$0.position == candidate.position})
        if let index = index {
            self.selectedCandidates.remove(at: index)
        }
    }
    
    func validateShuffleChoice() {
        var isCorrect = true
        for (index, candidate) in self.selectedCandidates.enumerated() {
            if(candidate.text != self.answers[index]) {
                isCorrect = false
                break
            }
        }
        withAnimation(.easeOut(duration: 0.2)) {
            self.shuffleStatus = (isCorrect ? ShuffleStatus.correct : ShuffleStatus.incorrect)
        }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(isCorrect ? .success : .warning)
    }
}
