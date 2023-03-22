//
//  ContentView.swift
//  Memorize
//
//  Created by Jay Van Nostrand on 3/3/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack  {
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
