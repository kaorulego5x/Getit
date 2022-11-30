//
//  MapRowView.swift
//  Getit
//
//  Created by kaorulego5x on 2022/09/02.
//

import SwiftUI

struct MapRowView: View {
    let progress: Progress
    let word: Word
    let isFocused: Bool
    let onToggle: (String) -> Void
    @StateObject var vm: MapRowViewModel
    
    init(eo: AppViewModel, progress: Progress, word: Word, isFocused: Bool, onToggle: @escaping (String) -> Void) {
        self.progress = progress
        self.word = word
        self.isFocused = isFocused
        self.onToggle = onToggle
        _vm = StateObject(wrappedValue: MapRowViewModel(eo: eo, progress: progress, word: word))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                self.onToggle(word.word)
            }) {
                HStack(){
                    Text(word.word.firstUppercased)
                        .lookup()
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 6){
                        Text("\(Int(vm.completePercentage))% (\(progress.index)/\(word.units.count))")
                            .small()
                            .foregroundColor(Color.subText)
                        
                        ZStack(alignment: .leading) {
                            HStack {}
                                .frame(width: 108, height:8)
                                .background(Color.lightBg)
                                .cornerRadius(2)
                            
                            HStack {}
                                .frame(width: 108 * CGFloat(vm.completePercentage) / 100, height:8)
                                .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(2)
                        }
                        .padding(.trailing, 12)
                    }
                    
                    Icon(.right, 16)
                        .foregroundColor(Color.subText)
                        .padding(8)
                        .rotationEffect(.degrees(isFocused ? 90 : -90))
                }
                .padding(.vertical, 14)
                .padding(.horizontal, 20)
                .contentShape(Rectangle())
            }
            .background(isFocused ? Color.white.opacity(0.05) : Color.white.opacity(0))
            .buttonStyle(MapRowButtonStyle())
            
            if(self.isFocused) {
                ForEach((0..<word.units.count)){ unitIndex in
                    let unit = word.units[unitIndex]
                    Button(action: {
                        self.vm.selectUnit(unit)
                    }){
                        HStack(spacing: 10){
                            if(unitIndex < progress.index) {
                                HStack {
                                    Text(String((Int(unit.unitId.components(separatedBy: "-")[1]) ?? 0) + 1))
                                        .mainBold()
                                        .foregroundColor(Color.white)
                                }
                                .frame(width: 32, height: 32)
                                .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(12)
                            } else {
                                HStack {
                                    Text(String((Int(unit.unitId.components(separatedBy: "-")[1]) ?? 0) + 1))
                                        .mainBold()
                                        .foregroundColor(Color.white)
                                }
                                .frame(width: 32, height: 32)
                                .background(Color.lightBg)
                                .cornerRadius(12)
                            }
                            
                            Text(UnitTypeText[unit.type] ?? "")
                                .smallJa()
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            if(unitIndex < progress.index) {
                                Icon(.replay, 16)
                                    .foregroundColor(Color.subText)
                                    .padding(8)
                            } else if (unitIndex == progress.index) {
                                Icon(.play, 16)
                                    .foregroundColor(Color.subText)
                                    .padding(8)
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(MapRowButtonStyle())
                }
            }
        }
        .accentColor(Color.subText)
    }
}

struct MapRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MapRowButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .opacity(1)
            .background(configuration.isPressed ? Color.white.opacity(0.03) : Color.white.opacity(0))
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
