//
//  GeometryReaderTest.swift
//  Getit
//
//  Created by kaorulego5x on 2022/07/28.
//

import SwiftUI

struct GeometryReaderTest: View {
    @State var frame: CGSize = .zero
    var body: some View {
                            HStack {
                    GeometryReader { (geometry) in
                        self.makeView(geometry)
                    }
                }
                
            
            
    }
    
    func makeView(_ geometry: GeometryProxy) -> some View {
        print(geometry.size.width, geometry.size.height)

        DispatchQueue.main.async { self.frame = geometry.size }

        return Text("Test")
                .frame(width: geometry.size.width)
    }
}

struct GeometryReaderTest_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderTest()
    }
}
