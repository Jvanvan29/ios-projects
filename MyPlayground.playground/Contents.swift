
import Foundation

class Animal{
    var name: String
    
    init (n: String){
        name = n
    }
    
}

class Human: Animal {
    
    func code(){
        print("Typing away ...")
    }
}

class Fish: Animal {
    
    func breathingUnderWater(){
        print("Breathing under water.")
    }
}

let angela = Human(n: "Angela Yu")
let jack = Human(n: "Jack Bauer")
let nemo = Fish(n: "Nemo")
let num = 12

let neighbours: [Any] = [angela, jack, nemo, num]

func findNemo(from animals: [Animal]) {
    
    for animal in animals{
        if animal is Fish{
            print(animal.name)
            let fish = animal as! Fish
            fish.breathingUnderWater()
        }
    }
}

findNemo(from: neighbours)
