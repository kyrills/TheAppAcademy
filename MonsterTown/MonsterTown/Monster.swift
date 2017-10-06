import Foundation

class Monster{
    var age: Int
    var name: String
    var monsterTeeth: teeth
    var allCrunchedBones: [Bone] = []
    
    init(age: Int, name: String, monsterTeeth: teeth) {
        self.age = age
        self.name = name
        self.monsterTeeth = monsterTeeth
    }


    func eatHuman(human: Human) -> [Bone] {
        if human.type == .boy{
            print("You just ate a boy")
        } else{
            print("Yuck")
        }
        crunchAllBones(bones: human.bones)
        return allCrunchedBones
        
    }

    func eatManyHumans(humans: [Human]) -> [Bone]{
        for currentHuman in humans{
            crunchAllBones(bones: currentHuman.bones)
        }
        return allCrunchedBones
    }

    func crunchAllBones(bones: [Bone]){
        for currentbone in bones{
            crunchBone(bone: currentbone)
        }
        
    }

    func crunchBone(bone: Bone){
        bone.crunched = true
        allCrunchedBones.append(bone)
        switch bone.type {
        case boneType.boyBone:
            print("You're crushing a boy!")
        case boneType.manBone:
            print("You're crushing a man!")
        case boneType.womanBone:
            print("You're crushing a woman!")
        }
    }
}
