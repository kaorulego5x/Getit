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

struct Session: Equatable {
    var phrase: Phrase
    var sessionType: SessionType
    static func ==(lhs: Session, rhs: Session) -> Bool {
        return lhs.phrase.en == rhs.phrase.en && lhs.phrase.ja == rhs.phrase.ja
    }
}

let randomChoices: [String] = ["on", "in", "it", "down", "upon", "to", "up"]

class ActivityViewModel: ObservableObject {
    let eo: AppViewModel
    let phraseRepository = PhraseRepository()
    private var cancellables: [AnyCancellable] = []
    
    @Published var route: ActivityRoute = .loading
    @Published var sessions: [Session] = []
    @Published var sessionIndex = -1
    @Published var currentSession: Session?
    @Published var correctNum = 0
    
    init(eo: AppViewModel) {
        self.eo = eo
    }
    
    func handleNext() {
        if(sessionIndex >= sessions.count - 1) {
            self.handleComplete()
        } else {
            withAnimation(.easeOut(duration:0.1)) {
                self.sessionIndex += 1
                // self.resetSession()
            }
        }
    }
    
    func handleComplete() {
        self.route = .result
        self.eo.levelUp()
    }
    
    func resetSession() {
        self.sessionIndex = 0
        let session = sessions[sessionIndex]
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
                let tempSessions = phrases.shuffled().map { phrase in
                    self.getSessionList(phrase: phrase, unitType: unit.type)
                }.flatMap { $0 }
                self.sessions = self.getShuffledSessionList(tempSessions)
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
    
    func getShuffledSessionList(_ sessionList: [Session]) -> [Session] {
        var rams: [Session] = []
        var idioms: [Session] = []
        var shuffles: [Session] = []
        for session in sessionList {
            switch(session.sessionType) {
            case .ram:
                rams.append(session)
                break
            case .idiom:
                idioms.append(session)
                break
            case .shuffle:
                shuffles.append(session)
                break
            }
        }
        return rams.shuffled() + idioms.shuffled() + shuffles.shuffled()
    }
}

func matches(for regex: String, in text: String) -> [String] {

    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range, in: text)!])
        }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
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

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
