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
    @Published var selectedUnit: Unit?
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
        let newUser = User(id: userId, progress: progress, phraseNum: 0, nextUp: "get-0")
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
    
    func startUnit(_ unit: Unit) {
        self.selectedUnit = unit
        self.transit(.activity)
    }
    
    func transit(_ tab: Tab){
        self.tab = tab
    }
    
    func levelUp() {
        if let unit = selectedUnit {
            let word = unit.unitId.components(separatedBy: "-")[0]
            let index = Int(unit.unitId.components(separatedBy: "-")[1])!
            if var user = user {
                if let masterData = masterData {
                    if let wordIndex = user.progress.firstIndex(where: { $0.word == word }) {
                        if(user.progress[wordIndex].index == index) {
                            user.progress[wordIndex].index += 1
                            user.phraseNum += 1
                            
                            let word = user.nextUp.components(separatedBy: "-")[0]
                            let index = Int(user.nextUp.components(separatedBy: "-")[1])!
                            let tempNext = "\(word)-\(String(index+1))"
                            var isNextExist = false
                            for word in masterData.words {
                                for unit in word.units {
                                    if (unit.unitId == tempNext) {
                                        isNextExist = true
                                        user.nextUp = tempNext
                                    }
                                }
                            }
                            if(!isNextExist) {
                                for word in masterData.words {
                                    let progress = user.progress.first(where: {$0.word == word.word})
                                    if let progress = progress {
                                        if (word.units.count == progress.index + 1) { continue }
                                        user.nextUp = word.units[progress.index].unitId
                                        return
                                    } else {
                                        print("Word didn't match")
                                    }
                                }
                            }
                            self.user = user
                            userRepository.updateProgress(id: user.id, progress: user.progress, phraseNum: user.phraseNum+1, nextUp: user.nextUp)
                                .sink(receiveCompletion: { completion in
                                    switch completion {
                                    case .finished: break;
                                    case .failure(let error): print(error)
                                    }
                                }, receiveValue: { _ in
                                    print("updated progress")
                                })
                                .store(in: &cancellables)
                        }
                    }
                }
            }
        }
    }
}
