//
//  PhraseRepository.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/03.
//

import Foundation
import Combine

protocol PhraseRepositoryProtocol {
    func fetchUnit(unitId: String) -> AnyPublisher<[Phrase], Error>
}

class PhraseRepository: PhraseRepositoryProtocol {
    func fetchUnit(unitId: String) -> AnyPublisher<[Phrase], Error> {
        let ref = FirebaseManager.shared.db.collection(FirestoreCollection.phrase.rawValue).whereField("unitId", isEqualTo: unitId)
        return FirebaseManager.shared.db.fetchAll(ref: ref)
    }
}
