//
//  QuestionRepository.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/03.
//

import Foundation
import Combine

protocol QuestionRepositoryProtocol {
    func fetchUnit(unitId: String) -> AnyPublisher<[Question], Error>
}

class QuestionRepository: QuestionRepositoryProtocol {
    func fetchUnit(unitId: String) -> AnyPublisher<[Question], Error> {
        let ref = FirebaseManager.shared.db.collection(FirestoreCollection.question.rawValue).whereField("unitId", isEqualTo: unitId)
        return FirebaseManager.shared.db.fetchAll(ref: ref)
    }
}
