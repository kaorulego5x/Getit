//
//  MasterdataRepository.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import Foundation
import Combine

protocol MasterDataRepositoryProtocol {
    /** ユーザーを取得 */
    func get() -> AnyPublisher<MasterData, Error>
}

class MasterDataRepository: MasterDataRepositoryProtocol {
    func get() -> AnyPublisher<MasterData, Error> {
        let ref = FirebaseManager.shared.db.collection(FirestoreCollection.masterdata.rawValue).document("v1")
        return FirebaseManager.shared.db.fetch(ref: ref)
    }
}
