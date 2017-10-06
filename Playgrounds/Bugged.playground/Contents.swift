func sumArray(arrayNumbers: [Int]) -> Int {
    var temp: Int = 0
    for i in arrayNumbers{
        temp += i
    }
    return temp
}

var numbers = [1,2,1,6,4,22,5,44,234,4,46,3,23234,34,346,45,3,2,213,4,46,65,]

var sentence = "Something tells me something."
var disemVoweledWord = ""

for letter in sentence{
    switch letter {
    case "a", "A", "e", "E", "i", "I", "u", "U", "o", "O":
        break
    default:
        disemVoweledWord.append(letter)
    }
//    print(disemVoweledWord)
}

func isEven(number num: Int) -> Bool{
    if num % 2 == 0{
        return true
    } else{
        return false
    }
}

func isThisOdd(number num: Int) -> Bool{
    if num % 2 != 0{
        return true
        } else {
        return false
    }
}

    print(isThisOdd(number:10))
