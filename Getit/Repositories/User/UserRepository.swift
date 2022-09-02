//
//  UserRepository.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import Foundation
import Combine

protocol UserRepositoryProtocol {
    /** ユーザーを取得 */
    func get(_ id: String) -> AnyPublisher<User, Error>
    
    func create(_ newUser: User) -> AnyPublisher<User, Error>
}

class UserRepository: UserRepositoryProtocol {
    func get(_ id: String) -> AnyPublisher<User, Error> {
        let ref = FirebaseManager.shared.db.collection(FirestoreCollection.user.rawValue).document(id)
        return FirebaseManager.shared.db.fetch(ref: ref)
    }
    
    func create(_ newUser: User) -> AnyPublisher<User, Error> {
        let ref = FirebaseManager.shared.db.collection(FirestoreCollection.user.rawValue)
        return FirebaseManager.shared.db.add(ref: ref, data: newUser)
    }
    
    func post(_ user: User) -> AnyPublisher<User, Error> {
        let ref = FirebaseManager.shared.db.collection(FirestoreCollection.user.rawValue).document(user.id)
        return FirebaseManager.shared.db.post(ref: ref, data: user)
    }
}
