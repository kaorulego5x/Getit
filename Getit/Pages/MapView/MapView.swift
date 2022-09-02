//
//  MapView.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import SwiftUI

var wordList = ["Get"]
var activityList = [1, 2, 3, 4]

struct MapView: View {
    @EnvironmentObject var eo: AppViewModel
    @StateObject var vm: MapViewModel
    
    init(eo: AppViewModel) {
        _vm = StateObject(wrappedValue: MapViewModel(eo: eo))
    }
    
    var body: some View {
        VStack() {
            ForEach(vm.masterData.words, id: \.self) { word in
                let progress = vm.user.progress.first(where: {$0.word == word.word})
                if let progress = progress {
                    MapRowView(progress: progress, word: word)
                }
            }
            Spacer()
        }
        .background(Color.bg.ignoresSafeArea())
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
