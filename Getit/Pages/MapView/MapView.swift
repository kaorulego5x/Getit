//
//  MapView.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/01.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var eo: AppViewModel
    @StateObject var vm: MapViewModel
    @State var focusedWord: String = ""
    
    init(eo: AppViewModel) {
        _vm = StateObject(wrappedValue: MapViewModel(eo: eo))
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = UIColor(.bg)
        UINavigationBar.appearance().standardAppearance = coloredAppearance
    }
    
    func handleToggle(word: String) {
        if(self.focusedWord == word) {
            withAnimation(.easeOut(duration:0.1)) {
                self.focusedWord = ""
            }
        } else {
            withAnimation(.easeOut(duration:0.1)) {
                self.focusedWord = word
            }
        }
    }
    
    var body: some View {
        ScrollView() {
            VStack(){
                ForEach(vm.masterData.words, id: \.self) { word in
                    let progress = vm.user.progress.first(where: {$0.word == word.word})
                    let isFocused = self.focusedWord == word.word
                    if let progress = progress {
                        MapRowView(eo: self.eo, progress: progress, word: word, isFocused: isFocused, onToggle: handleToggle)
                    }
                }
                Spacer()
            }
        }
        .background(Color.bg.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("ユニット一覧")
                    .smallJa()
                    .foregroundColor(.white)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
