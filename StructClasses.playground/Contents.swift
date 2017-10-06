//: Playground - noun: a place where people can play

import UIKit

class BankAccount{
    var balance: Double
    
    init(balance: Double) {
        self.balance = balance
    }
    
}

class Person {
    var name: String
    var account: BankAccount
    init(name: String, account: BankAccount) {
        self.name = name
        self.account = account
    }
}

var account1 = BankAccount.init(balance: 100)
var account2 = BankAccount.init(balance: 100)

print (account1)
print(account2)

if account1 === account2{
    print("Same account")
}

var person1 = Person.init(name: "Kyrill", account: account1)
var person2 = Person.init(name: "GF", account: account1)

print("\(person1.name): \(person1.account.balance)")
print("\(person2.name): \(person2.account.balance)")

person1.account.balance = 300

print("\(person1.name): \(person1.account.balance)")
print("\(person2.name): \(person2.account.balance)")

var name1 = "Ben"
var name2 = "Ben"

if name1 == name2 {
    print("Same name")
} else {
    print("Different name")
}

var number1 = 1
var number2 = number1

if number1 == number2 {
    print("Same number")
}

number1 = 5
print(number1)
print (number2)


struct Wallet {
    var cash: Double
    init(cash: Double){
        self.cash = cash
    }
}

var wallet1 = Wallet.init(cash: 40.0)
var wallet2 = wallet1

wallet1.cash = 100

print (wallet1.cash)
print (wallet2.cash)


