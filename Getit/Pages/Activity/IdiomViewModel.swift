//
//  IdiomViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 30/11/22.
//

import SwiftUI
import Foundation

struct IdiomChoice {
    var text: String
    var isCorrect: Bool
}

let randomChoices: [String] = ["on", "in", "it", "down", "upon", "to", "up"]

class IdiomViewModel: ObservableObject {
    @Published var baseEnSentence: String?
    @Published var idiomChoices: [IdiomChoice] = []
    @Published var displayIdiomChoices: [IdiomChoice] = []
    @Published var selectedChoiceIndex: Int = -1
    @Published var isIdiomChoiceDone: Bool = false

    func reset(_ session: Session) {
        self.idiomChoices = []
        self.displayIdiomChoices = []
        self.selectedChoiceIndex = -1
        self.isIdiomChoiceDone = false
        
        var enComponents = session.phrase.en.components(separatedBy: " ")
        if let blankIndex = enComponents.firstIndex(where: { $0.contains("`")}) {
            let correctMatches = matches(for: "`.*`", in: enComponents[blankIndex])
            enComponents[blankIndex] = enComponents[blankIndex].replacingOccurrences(of: correctMatches[0], with: "#")
        } else {
            print("Error occurred while generating en sentence")
        }
        self.baseEnSentence = enComponents.joined(separator: " ")
        
        let correctPart = session.phrase.en.components(separatedBy: " ").first(where: { $0.contains("`") })
        if let correctPart = correctPart {
            let correctMatches = matches(for: "`.*`", in: correctPart)
            let correctAnswer = correctMatches[0].replacingOccurrences(of: "`", with: "").lowercased()
            self.idiomChoices.append(IdiomChoice(text: correctAnswer, isCorrect: true))
            let otherChoices = randomChoices.filter { $0 != correctAnswer }.shuffled()
            for i in 0..<4 {
                self.idiomChoices.append(IdiomChoice(text: otherChoices[i], isCorrect: false))
            }
            self.displayIdiomChoices = self.idiomChoices.shuffled()
        } else {
            print("Idiom not found")
        }
    }
    
    func selectChoice(_ choice: IdiomChoice) {
        if let index = self.idiomChoices.firstIndex(where: {$0.text == choice.text}) {
            withAnimation(.easeOut(duration: 0.2)) {
                self.selectedChoiceIndex = index
            }
        } else {
            print("Error occurred when selecting idiom choice")
        }
    }
    
    func validateIdiomChoice() {
        withAnimation(.easeOut(duration: 0.2)) {
            self.isIdiomChoiceDone = true
        }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(self.selectedChoiceIndex == 0 ? .success : .warning)
    }
}
