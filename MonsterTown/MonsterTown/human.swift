import Foundation

class Human{
    var name: String
    var type: humanType
    var bones: [Bone]
    
    init(name: String, type: humanType, bones: [Bone]) {
        self.name = name
        self.type = type
        self.bones = bones
    }
    
    func talk(word: String){
        var test = ""
        
    }
}
