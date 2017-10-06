import UIKit
//Create a common type of variable
struct Address {
    var number: Int
    var firstLine: String
    var secondLine: String
    var postCode: String
}
//reuse address
// Don't have to copy and rewrite the variables in address
struct Client {
    var name: String
    var phoneNumber: Int
    var email: String
    var address: Address
}
struct Company {
    var name: String
    var phoneNumber: Int
    var email: String
    var address: Address
}
