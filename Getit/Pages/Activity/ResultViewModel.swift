//
//  File.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/04.
//

import Foundation

class ResultViewModel: ObservableObject {
    let eo: AppViewModel
    
    init(eo: AppViewModel) {
        self.eo = eo
    }
    
    func transitToHome() {
        self.eo.transit(.home)
    }
    
    func completeUnit() {
       
    }
}
