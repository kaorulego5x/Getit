//
//  AppViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 2022/06/30.
//

import Foundation
import Combine

enum Tab {
    case home
    case loading
    case activity
}

class AppViewModel: ObservableObject {
    @Published var tab: Tab = Tab.home
    @Published var loaded: Bool = false
    @Published var masterData: MasterData?
    @Published var user: User?
    var masterDataRepository = MasterDataRepository()
    var userRepository = UserRepository()
    private var cancellables: [AnyCancellable] = []

    deinit {
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }
    
    func handleLaunch() -> Void {
        self.fetchMasterData() { masterData in
            self.handleAuth(masterData)
        }
    }
    
    func handleAuth(_ masterData: MasterData) {
        if let currentUser = FirebaseManager.shared.auth.currentUser { //アプリを開いたことがある場合
            self.fetchUserData(currentUser.uid, masterData)
        } else { //初めてアプリを開いた場合
            FirebaseManager.shared.auth.signInAnonymously() { [weak self] authResult, error in
                guard let user = authResult?.user else {
                    print("Registration failed")
                    return
                }
                self?.fetchUserData(user.uid, masterData)
            }
        }
    }
    
    func fetchMasterData(completion: @escaping (MasterData) -> Void) {
        masterDataRepository
            .get()
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
        }, receiveValue: { masterData in
            self.masterData = masterData
            completion(masterData)
        })
        .store(in: &cancellables)
    }
    
    func fetchUserData(_ id: String, _ masterData: MasterData) {
        userRepository
            .get(id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break;
                case .failure(let error):
                    switch error {
                    case FirestoreError.notFoundError:
                        self.register(userId: id, masterData)
                    default:
                        print(error)
                    }
                }
            }, receiveValue: { user in
                self.user = user
                self.loaded = true
            })
            .store(in: &cancellables)
    }
    
    func register(userId: String, _ masterData: MasterData) {
        let progress = masterData.words.map { return Progress(word: $0.word, index: 0)}
        let newUser = User(id: userId, progress: progress, questionNum: 0)
        userRepository.post(newUser)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break;
                case .failure(let error): print(error)
                }
            }, receiveValue: { user in
                self.user = user
                self.loaded = true
            })
            .store(in: &cancellables)
    }
    
    func transit(_ tab: Tab){
        self.tab = tab
    }
}
