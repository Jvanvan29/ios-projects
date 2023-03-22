
class Enemy{
    var health: Int
    var attackStrength: Int
    
    func move(){
        print("walk forwards.")
    }
    
    func attack(){
        print("Land a hit, does \(attackStrength) damage.")
    }
    
}
