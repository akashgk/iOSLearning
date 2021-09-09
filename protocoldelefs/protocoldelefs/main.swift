protocol AdvanceLifeSupport {
    func performCpr()
}


class EmergenceCallHandler {
    var delegate : AdvanceLifeSupport?
    
    func assesSituation(){
        print("can you tell me what happened")
    }
    
    func medicalEmergency()  {
        delegate?.performCpr()
    }
}


struct Paramedic : AdvanceLifeSupport {
    init(handler : EmergenceCallHandler) {
        handler.delegate = self
    }
    func performCpr() {
        print("paramedic does cpr for 30 seconds")
    }
}

class Doctor : AdvanceLifeSupport {
    init(handler : EmergenceCallHandler) {
        handler.delegate = self    }
    
    func performCpr() {
    print("doctor does cpr")
    }
    
    func useSteth()  {
        print("listening for heart sounds")
    }
}


class  Surgeon: Doctor {
    override func performCpr() {
        super.performCpr()
        print("S")
    }
}

var emergencyCaller : EmergenceCallHandler = EmergenceCallHandler()
var paramedic: Paramedic = Paramedic(handler: emergencyCaller)

var  angela : Surgeon = Surgeon(handler: emergencyCaller)


emergencyCaller.assesSituation()
emergencyCaller.medicalEmergency()
