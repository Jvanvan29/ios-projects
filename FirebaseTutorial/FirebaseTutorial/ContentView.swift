//
//  ContentView.swift
//  FirebaseTutorial
//
//  Created by Jay Van Nostrand on 2/25/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Color(.black)
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink, .red], startPoint:
                        .topLeading, endPoint: .bottomTrailing))

        }.ignoresSafeArea()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
