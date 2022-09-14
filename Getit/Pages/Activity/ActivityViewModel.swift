//
//  ActivityViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import Foundation
import SwiftUI
import Combine

enum ActivityRoute: String {
    case loading = "loading"
    case activity = "activity"
    case result = "result"
}

class ActivityViewModel: ObservableObject {
    let eo: AppViewModel
    let questionRepository = QuestionRepository()
    private var cancellables: [AnyCancellable] = []
    
    @Published var route: ActivityRoute = .loading
    @Published var questions: [Question]?
    @Published var questionIndex = 0
    @Published var correctNum = 0
    
    var seconds = 0.0
    var timer = Timer()
    @Published var secondsElapsed = 0.0
    @Published var isAnswerVisible = false
    
    init(eo: AppViewModel) {
        self.eo = eo
    }
    
    func handleNext(isCorrect: Bool) {
        if(isCorrect) {
            self.correctNum += 1
        }
        if let questions = questions {
            if(questionIndex + 1 >= questions.count) {
                self.route = .result
            } else {
                self.isAnswerVisible = false
                self.questionIndex += 1
                self.startTimer()
            }
        }
    }
    
    func fetchUnit() {
        if let unitId = eo.selectedUnit {
            questionRepository
                .fetchUnit(unitId: unitId)
                .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break;
                case .failure(let error):
                    switch error {
                    case FirestoreError.notFoundError:
                        print(error);
                    default:
                        print(error)
                    }
                }
            }, receiveValue: { questions in
                self.route = .activity
                self.questions = questions
                self.startTimer()
            })
            .store(in: &cancellables)
        }
    }
    
    func startTimer() {
        self.seconds = 0
        self.secondsElapsed = 0
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
