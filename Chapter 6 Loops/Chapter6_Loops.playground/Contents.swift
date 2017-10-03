import UIKit

var cnt: Int = 0
for i in 0...4 {
    cnt += 1
    print("Index is", i)
    print (cnt)
}

enum Stones {
    case Red
    case Blue
    case Green
    case Purple
}

var inventory: [Stones]
inventory = [.Red, .Green, .Blue, .Purple, .Green, .Red]

for item in inventory {
    print(item)
}

var numbers: [Int] = []
var counting: Int = 0

while numbers.count <= 10{
    numbers.append(counting)
    counting += 10
    print("\(index): \(numbers)")
//    print(numbers)
}

var names: [String] = []

names.append("Kyrill")
names.append("Michiel")
names.append("Trym")
names.append("Bart")

for (index, name) in names.enumerated() {
    print ("\(index): \(name)" )
}
