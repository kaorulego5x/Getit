//
//  ActivityViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

enum ActivityRoute: String {
    case loading = "loading"
    case activity = "activity"
    case result = "result"
}

enum SessionType: String {
    case ram = "ram"
    case idiom = "idiom"
    case shuffle = "shuffle"
}

struct Session {
    var phrase: Phrase
    var sessionType: SessionType
}

struct EnPart: Identifiable {
    var text: String
    var isSpeeched: Bool
    var id: UUID
}

struct IdiomChoice {
    var text: String
    var isCorrect: Bool
}

let randomChoices: [String] = ["on", "in", "it", "down", "upon", "to", "up"]

class ActivityViewModel: ObservableObject {
    let eo: AppViewModel
    let phraseRepository = PhraseRepository()
    private var cancellables: [AnyCancellable] = []
    
    @Published var route: ActivityRoute = .loading
    @Published var currentSession: Session?
    var sessions: [Session] = []
    @Published var sessionIndex = 0
    @Published var correctNum = 0
    
    // RAM
    @Published var enParts: [EnPart] = []
    @Published var isCompleted: Bool = false
    
    // Idiom
    @Published var idiomChoices: [IdiomChoice] = []
    @Published var displayIdiomChoices: [IdiomChoice] = []
    @Published var selectedChoiceIndex: Int = -1
    @Published var isIdiomChoiceDone: Bool = false
    
    init(eo: AppViewModel) {
        self.eo = eo
    }
    
    func handleNext() {
        if(sessionIndex >= sessions.count - 1) {
            self.route = .result
        } else {
            self.sessionIndex += 1
            self.resetSession()
        }
    }
    
    func resetSession() {
        self.currentSession = sessions[self.sessionIndex]
        self.enParts = []
        self.isCompleted = false
        self.idiomChoices = []
        self.displayIdiomChoices = []
        self.selectedChoiceIndex = -1
        self.isIdiomChoiceDone = false
        let session = sessions[sessionIndex]
        switch(session.sessionType) {
        case .ram:
            self.enParts = session.phrase.en.components(separatedBy: " ").map { component in
                return EnPart(text: component.replacingOccurrences(of: "`", with: ""), isSpeeched: false, id: UUID())
            }
        case .idiom:
            let correctAnswer = session.phrase.en.components(separatedBy: " ").first(where: { $0.contains("`") })?.replacingOccurrences(of: "`", with: "")
            if let correctAnswer = correctAnswer?.lowercased() {
                self.idiomChoices.append(IdiomChoice(text: correctAnswer, isCorrect: true))
                let otherChoices = randomChoices.filter { $0 != correctAnswer }.shuffled()
                for i in 0..<4 {
                    self.idiomChoices.append(IdiomChoice(text: otherChoices[i], isCorrect: false))
                }
                self.displayIdiomChoices = self.idiomChoices.shuffled()
            } else {
                print("Idiom not found")
            }
        case .shuffle:
            return
        }
    }
    
    func fetchUnit() {
        if let unit = eo.selectedUnit {
            phraseRepository
                .fetchUnit(unitId: unit.unitId)
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
            }, receiveValue: { phrases in
                self.sessions = phrases.shuffled().map { phrase in
                    self.getSessionList(phrase: phrase, unitType: unit.type)
                }.flatMap { $0 }
                self.route = .activity
                self.resetSession()
            })
            .store(in: &cancellables)
        }
    }
    
    func getSessionList(phrase: Phrase, unitType: UnitType) -> [Session] {
        var res: [Session] = []
        switch unitType {
        case .single:
            res.append(Session(phrase: phrase, sessionType: .ram))
        case .idiom:
            res.append(Session(phrase: phrase, sessionType: .ram))
            res.append(Session(phrase: phrase, sessionType: .idiom))
        case .practical:
            res.append(Session(phrase: phrase, sessionType: .ram))
            res.append(Session(phrase: phrase, sessionType: .shuffle))
        }
        return res
    }
    
    // RAM
    func handleSpeechInput(_ transcript: String) {
        let inputParts = transcript.lowercased().components(separatedBy: " ")
        var carry = 0
        for (index, part) in enParts.enumerated() {
            var a: String = part.text.lowercased()
            if(a.contains("!?") || a.contains("?!") || a.contains("!!")) {
                a.removeLast()
                a.removeLast()
            } else if(a.contains(",") || a.contains(".") || a.contains("…") || a.contains("!") || a.contains("?")) {
                a.removeLast()
            }
                
            if(part.isSpeeched) {
                continue
            } else if(inputParts.contains(a)) {
                withAnimation(.easeOut(duration: 0.2)) {
                    self.enParts[index].isSpeeched = true
                }
                if(index == enParts.count - 1) {
                    self.handleCompleted()
                }
                if(carry == 1) {
                    withAnimation(.easeOut(duration: 0.2)) {
                        self.enParts[index-1].isSpeeched = true
                    }
                }
            } else if (carry == 0){
                carry = 1
            } else {
                break
            }
        }
    }
    
    private func handleCompleted() {
        self.isCompleted = true
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    // Idiom
    func selectChoice(choice: IdiomChoice) {
        if let index = self.idiomChoices.firstIndex(where: {$0.text == choice.text}) {
            self.selectedChoiceIndex = index
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

internal class Speaker: NSObject, ObservableObject {
    internal var errorDescription: String? = nil
    private let synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking: Bool = false
    @Published var isShowingSpeakingErrorAlert: Bool = false

    override init() {
        super.init()
        self.synthesizer.delegate = self
    }

    internal func speak(_ text: String, language: String) {
        do {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: language)
            
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.synthesizer.speak(utterance)
        } catch let error {
            self.errorDescription = error.localizedDescription
            isShowingSpeakingErrorAlert.toggle()
        }
    }
    
    internal func stop() {
        self.synthesizer.stopSpeaking(at: .immediate)
    }
}

extension Speaker: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        self.isSpeaking = true
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        self.isSpeaking = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.isSpeaking = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
}
