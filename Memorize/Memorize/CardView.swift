//
//  CardView.swift
//  Memorize
//
//  Created by Jay Van Nostrand on 3/4/23.
//

import SwiftUI

struct CardView: View{
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
            Text("✈️")
                font(.largeTitle)
        }
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
