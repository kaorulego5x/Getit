//
//  HomeView.swift
//  Geit
//
//  Created by Kaoru Nishihara on 2021/11/28.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: GlobalStore
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        VStack(){
            HStack(){
                Icon(.award, 12)
                    .foregroundColor(.white)
            }
        }
        .ignoresSafeArea()
        .background(Color.bg)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
