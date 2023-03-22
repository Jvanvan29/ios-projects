//
//  Dragon.swift
//  ClassesDemo
//
//  Created by Jay Van Nostrand on 3/7/23.
//

class Dragon: Enemy {
    
    var wingSpan = 2
    
    func talk(speech: String){
        print("Says: \(speech)")
    }
    
    override func move(){
        
        print("fly forwards")
        
    }
    
    override func attack(){
        super.attack()
        print("spit bars + fire, 10 damage bitch")
    }
    
}
