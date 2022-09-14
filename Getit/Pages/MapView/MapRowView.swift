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
    @StateObject var vm: MapRowViewModel
    
    init(eo: AppViewModel, progress: Progress, word: Word) {
        self.progress = progress
        self.word = word
        _vm = StateObject(wrappedValue: MapRowViewModel(eo: eo, progress: progress, word: word))
    }
    
    var body: some View {
        DisclosureGroup(
            content: {
                VStack{
                    ForEach((0..<word.units.count)){ unitIndex in
                        let unit = word.units[unitIndex]
                        HStack(spacing: 10){
                            if(unitIndex < progress.index) {
                                HStack {
                                    Text(unit.unitId.components(separatedBy: "-")[1])
                                        .mainBold()
                                        .foregroundColor(Color.white)
                                }
                                .frame(width: 32, height: 32)
                                .background(LinearGradient(gradient: Color.learnGrad, startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(12)
                            } else {
                                HStack {
                                    Text(unit.unitId.components(separatedBy: "-")[1])
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
                            
                            Button(action: {
                                self.vm.selectUnit(unit)
                            }){
                                if(unitIndex < progress.index) {
                                    Icon(IconName.replay, 16)
                                        .foregroundColor(Color.subText)
                                        .padding(8)
                                } else if (unitIndex == progress.index) {
                                    Icon(IconName.play, 16)
                                        .foregroundColor(Color.subText)
                                        .padding(8)
                                }
                                
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            },
            label:{
                HStack(){
                    Text(word.word.firstUppercased)
                        .lookup()
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 6){
                        Text("\(Int(vm.completePercentage))% (\(progress.index)/\(word.units.count))")
                            .small()
                            .foregroundColor(Color.subText)
                        
                        ZStack(alignment: .leading){
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
                }
                .padding(.vertical, 12)
            }
        )
        .accentColor(Color.subText)
        .padding(.horizontal, 20)
    }
}

struct MapRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
