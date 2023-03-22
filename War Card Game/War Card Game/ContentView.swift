//
//  ContentView.swift
//  War Card Game
//
//  Created by Jay Van Nostrand on 2/24/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var playerCard:String = "card7"
    @State var cpuCard:String = "card4"
    
    @State var playerScore:Int = 0
    @State var cpuScore:Int = 0
    
    var body: some View {
        
        ZStack{
            Image("background-plain")
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .center){
                
                Spacer()
                Image("logo").shadow(radius: 15).padding()
                HStack{
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                
                Spacer()
                
                Button {
                    deal()
                } label: {
                    Image("button")
                }

                Spacer()
                
                HStack{
                    Spacer()
                    VStack{
                        Text("Player")
                            .font(.headline)
                            .padding(.bottom, 10)
                        Text(String(playerScore))
                            .font(.largeTitle)
                    }.foregroundColor(.white)
                    Spacer()
                    VStack{
                        Text("CPU")
                            .font(.headline)
                            .padding(.bottom, 10)
                        Text(String(cpuScore))
                            .font(.largeTitle)
                    }.foregroundColor(.white)
                    Spacer()
                    
                }
                Spacer()

                
            }
            
        }

    }

    func deal(){
        // Randomize the player card
        let playerValue = String(Int.random(in: 2...14))
        playerCard = "card" + String(playerValue)
        
        //Randomize the cpus card
        let cpuValue = String(Int.random(in: 2...14))
        cpuCard = "card" + String(cpuValue)
        
        //Update the scores
        if playerValue > cpuValue {
            playerScore = playerScore + 1
        }
        else if cpuValue > playerValue{
            cpuScore = cpuScore + 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
