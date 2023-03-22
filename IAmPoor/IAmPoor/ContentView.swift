//
//  ContentView.swift
//  IAmPoor
//
//  Created by Jay Van Nostrand on 2/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            
            VStack{
                Text("I Am Poor")
                    .foregroundColor(.teal)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Image("coal")
                    .foregroundColor(Color.orange)
                    
                
            }
            Spacer()
            
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
