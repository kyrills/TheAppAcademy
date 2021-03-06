//: Playground - noun: a place where people can play

import UIKit

var isItRaining: Bool = true

if isItRaining {
    print("It's raining man!")
} else {
    print ("Enjoy your sunny day!")
}

var population: Int = 1000000000000
var message: String

if population <= 10000 {
    message = "\(population) is a small town!"
} else if population > 100000{
    message = "\(population) is massive!"
} else {
    message = " \(population) is pretty big"
}
print (message)

message = population < 10000 ? " \(population) is a small town!" : "\(population) is pretty big!"
print(message)

var statusCode: Int  = 403
var errorString: String
switch statusCode {
case 400:
    errorString = "Bad request"
case 401:
    errorString = "Unauthorised"
case 403:
    errorString = "Forbidden"
case 404:
    errorString = "Not found"
default:
    errorString = "Not known"
}

print(errorString)

switch statusCode {
case 400...499:
    errorString = "Something went worng."
default:
    errorString = "Not known"
}

print(errorString)


enum Stones {
    case Red
    case Blue
    case Green
    case Purple
}

var colourStones: Stones = Stones.Blue
var message1: String
switch colourStones {
case .Red:
    message1 = "You got the Red stone"
case .Blue:
    message1 = "You got the Blue stone"
case .Green:
    message1 = "You got the Green stone"
case .Purple:
    message1 = "You got the Purple stone"
}

print(message1)
