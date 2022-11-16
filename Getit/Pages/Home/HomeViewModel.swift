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
        self.progressRate = CGFloat(self.user.phraseNum) / CGFloat(self.masterData.totalPhraseNum)
        for word in self.masterData.words {
            for unit in word.units {
                if (unit.unitId == self.user.nextUp) {
                    self.nextUp = unit
                }
            }
        }
    }
    
    func transitToActivity() {
        if let nextUp = nextUp {
            self.eo.startUnit(nextUp)
        }
    }
}
