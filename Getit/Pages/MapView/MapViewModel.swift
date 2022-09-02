//
//  MapViewModel.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/02.
//

import Foundation

class MapViewModel: ObservableObject {
    let eo: AppViewModel
    let masterData: MasterData
    let user: User
    
    init(eo: AppViewModel) {
        self.eo = eo
        self.masterData = eo.masterData!
        self.user = eo.user!
    }
}
