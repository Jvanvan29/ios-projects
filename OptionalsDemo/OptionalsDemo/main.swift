
//Explainations for
//Protocols & Delegates


protocol AdvancedLifeSupport{
 
    func performCPR()
    
}

class EmergencyCallHandler{
    
    var delegate: AdvancedLifeSupport?
    
    func takeCalls(){
         
    }
    
    func assessSituation(){
        print("Can you tell me what happend?")
    }
    
    
    func medicalEmergency(){
        
        delegate?.performCPR()
        
    }
}

struct Paramedic: AdvancedLifeSupport{
    
    init(handler: EmergencyCallHandler){
        handler.delegate = self
    }
    
    func performCPR() {
        print("perform CPR")
    }
    
}

