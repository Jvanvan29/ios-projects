//
//  ContentView.swift
//  StanfordApp
//
//  Created by Jay Van Nostrand on 3/4/23.
//

import SwiftUI

struct ContentView: View {
    
    var emojis = [" 🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", " 🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵" ,"🏍", "🚔", "🚍", "🚘", "🚖", "✈️", "🚤", "🛥", "🛳", "⛴", "🚢"]
                   
    var faces =  ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "🥲", "🥹", "☺️", "😊", "😇", "🙂", "🙃", "😉", "😌", "😍", "🥰", "😘", "😗", "😙", "😚", "😋", "😛", "😝", "😜", "🤪", "🤨"]
    
    var fruits = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌶", "🫑"]
    
    @State var emojiType = "Travel"
    @State var emojisCount = 10
    
    var body: some View {
        
        VStack{
            
                Text("Memory Flip!")
                    .font(.largeTitle)
                    .foregroundColor(.mint)
                    .fontWeight(.bold)
            
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive( minimum: 65))]){
                        
                        if emojiType == "Travel" {
 
                            ForEach(emojis[0..<13], id: \.self){ emoji in
                                CardView( content: emojis.randomElement()! ).aspectRatio(2/3, contentMode: .fit)  }.foregroundColor(.red)
                            
                        }else if emojiType == "Faces" {
                        
                            ForEach(faces[0..<13], id: \.self){ face in
                                CardView( content: faces.randomElement()! ).aspectRatio(2/3, contentMode: .fit)  }.foregroundColor(.yellow)
                        }else if emojiType == "Fruits" {
                            
                            ForEach(fruits[0..<13], id: \.self){ fruit in
                                CardView( content: fruits.randomElement()! ).aspectRatio(2/3, contentMode: .fit)  }.foregroundColor(.green)
                        }

                        }
                }
            
            HStack{
                VStack{
                    Button(action: {
                           emojiType = "Travel"
                        }, label: { Image(systemName: "car")} )
                    Text("Vehicles")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
            
                }
                .font(.largeTitle)
                 
                Spacer()
                VStack{
                    Button(action :{
                        emojiType = "Faces"
                    },
                           label: { Image(systemName: "face.smiling")})
                    Text("Faces")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                }
                 .font(.largeTitle)
                    
                Spacer()
                VStack{
                    Button(action :{
                        emojiType = "Fruits"
                    }, label: { Image(systemName: "fork.knife.circle")})
                    Text("Fruits")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .font(.largeTitle)
                
            }.padding(15)
            
            }
        }
    }
    

struct CardView: View{
    
    @State var isFaceUp: Bool = true
    var content: String
    
    var body: some View{
        
        ZStack{
            
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
               shape.fill().foregroundColor(.white)
               shape.strokeBorder(lineWidth: 3)
               Text(content).font(.largeTitle)
            } else{
                shape.fill()
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
