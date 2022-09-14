//
//  HomeViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 2022/06/30.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    let eo: AppViewModel
    let masterData: MasterData
    let user: User
    var nextUp: Unit?
    @Published var progressRate: CGFloat = 0
    @Published var num = 0
    
    init(eo: AppViewModel){
        self.eo = eo
        self.masterData = eo.masterData!
        self.user = eo.user!
        self.progressRate = CGFloat(self.user.questionNum) / CGFloat(self.masterData.totalQuestionNum)
        for word in self.masterData.words {
            let progress = self.user.progress.first(where: {$0.word == word.word})
            if let progress = progress {
                if (word.units.count == progress.index + 1) { continue }
                self.nextUp = word.units[progress.index]
                return
            } else {
                print("Word didn't match")
            }
        }
    }
    
    func transitToActivity() {
        if let nextUp = nextUp {
            self.eo.startUnit(nextUp)
        }
    }
}
