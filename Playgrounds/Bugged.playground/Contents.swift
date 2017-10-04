func sumArray(arrayNumbers: [Int]) -> Int {
    var temp: Int = 0
    for i in arrayNumbers{
        temp += i
    }
    return temp
}

var numbers = [1,2,1,6,4,22,5,44,234,4,46,3,23234,34,346,45,3,2,213,4,46,65,]

print(sumArray(arrayNumbers: numbers))
