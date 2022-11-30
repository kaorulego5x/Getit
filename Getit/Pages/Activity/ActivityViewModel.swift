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
