import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

enum FirestoreError: Error {
    case notFoundError
    case validationError
}

struct FirestoreEncodeError: Error {
    
}

enum FirestoreCollection: String {
    case masterdata = "masterdata"
    case question = "question"
    case user = "user"
}


// CRUD処理
public extension Firestore {
    /// 追加
    func add<T: Codable>(ref: CollectionReference, data: T) -> AnyPublisher<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let `self` = self else { return }
            
            do {
                let encodeData = try self.encode(data: data)
                ref.addDocument(data: encodeData) { error in
                    
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    promise(.success(data))
                }
            } catch let error {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func post<T: Codable>(ref: DocumentReference, data: T) -> AnyPublisher<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let `self` = self else { return }
            
            do {
                let encodeData = try self.encode(data: data)
                ref.setData(encodeData) { error in
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    promise(.success(data))
                }
            } catch let error {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    /// コレクション内ドキュメント全取得
    func fetchAll<T: Codable>(ref: Query) -> AnyPublisher<[T], Error> {
        return Future<[T], Error> { promise in
            ref.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                if let snapshot = snapshot {
                    do {
                        let entities: [T] = try snapshot.documents.compactMap {
                            try Self.Decoder().decode(T.self, from: $0.data(), in: $0.reference)
                        }
                        promise(.success(entities))
                    } catch(let error) {
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }

    /// 単一ドキュメント取得
    func fetch<T: Codable>(ref: DocumentReference) -> AnyPublisher<T, Error> {
        return Future<T, Error> { promise in
            ref.getDocument { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                if let snapshot = snapshot {
                    do {
                        if let data = snapshot.data(), snapshot.exists {
                            let entity: T = try Self.Decoder().decode(T.self, from: data, in: snapshot.reference)
                            promise(.success(entity))
                        } else {
                            print("Not Found")
                            promise(.failure(FirestoreError.notFoundError))
                        }
                    } catch(let error) {
                        print("Unexpected Error")
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// 更新
    func update(ref: DocumentReference, data: [String: Any]) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            ref.updateData(data) { error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                promise(.success(()))
            }
        }.eraseToAnyPublisher()
    }

    /// 削除
    func delete(ref: DocumentReference) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            ref.delete { error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func encode<T: Codable>(data: T) throws -> [String: Any] {
        do {
            return try Firestore.Encoder().encode(data)
        } catch {
            throw FirestoreEncodeError()
        }
    }
}
