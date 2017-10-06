import Foundation

var boyBones: [Bone] = []
var manBones: [Bone] = []
var womanBones: [Bone] = []

for loopcounter in 1...10{
    boyBones.append(Bone.init(type: .boyBone, crunched: false))
    manBones.append(Bone.init(type: .manBone, crunched: false))
    womanBones.append(Bone.init(type: .womanBone, crunched: false))
    
}
var theBoy = Boy.init(name: "Adam", type: .boy, bones: boyBones)
var theMan = Man.init(name: "Senior", type: .man, bones: manBones)
var theWoman = Woman.init(name: "Linda", type: .woman, bones: womanBones)
var humansToEat: [Human] = [theBoy, theMan, theWoman]

var monster1 = Monster.init(age: 20, name: "Grumpy", monsterTeeth: .boyTeeth)
//var bonesReturned = monster1.eatHuman(human: theBoy)
var multipleBonesReturned = monster1.eatManyHumans(humans: humansToEat)

//print (bonesReturned)

//print(multipleBonesReturned)

