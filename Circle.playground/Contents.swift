//: Playground - noun: a place where people can play

import UIKit
//
////var natoAlphabet: [String] = [a: "Alpha", b: "Bravo", c: "Charlie", d: "Delta"]
////var dict1: Dictionary<String, String> = ["a": "Alpha", "b": "Bravo", "c": "Charlie", "d": "Delta"]
//
////var natoString: String = "abcd";
//
////for i in natoString {
////    natoString += dict1(natoString(i))
////}
//
////for (var i = 0, len = natoString.length; i < len; i++) {
////    natoString += natoAlphabet[natoString[i]]
////};
//
//var english: Dictionary<String, String> = ["a" : "abc", "b" : "bcd" ]
//var dutch: Dictionary<String, String> = ["test" : "testing" ]
//var french: Dictionary<String, String> = [:]
//var ratings: Dictionary<String, Int> = [:]
//
//var arrayofdictionaries = [english, dutch, french]
//
//for i in arrayofdictionaries {
//    print (i)
//    switch i {
//    case english:
//        print (i["a"])
//    case dutch:
//        print (i["test"])
////    }
////    if i == english {
////        print (i["a"])
////    }
////    if i == dutch {
////        print (i["test"])
////    }
//}
//
//ratings.updateValue(9, forKey: "MasterMovies")
//ratings.updateValue(8, forKey: "James Bond")
//print(ratings)
//ratings.updateValue(7, forKey: "MasterMovies")
//print(ratings)


//Here is the escaped string...just imagine this is our data retrieved from a server! Like for real!!!
var itemsJSONString = "{\n\t\"PraxisItemsForSale\": [{\n\t\t\"id\": 1,\n\t\t\"name\": \"A green door\",\n\t\t\"price\": 12.50,\n\t\t\"tags\": [\"home\", \"green\"]\n\t}, {\n\t\t\"id\": 2,\n\t\t\"name\": \"A saw\",\n\t\t\"price\": 10,\n\t\t\"tags\": [\"garden\", \"home\"]\n\t}]\n}"


//The clever parsed, it deserialises the JSON, don't worry about it too much lot of complicated things here
extension String {

    var parseJSONString: AnyObject? {

        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)

        if let jsonData = data {
            do {
                let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
                return message as AnyObject?
            }
            catch let error as NSError
            {
                print("An error occurred: \(error)")
                return nil
            }

            // Will return an object or nil if JSON decoding fails
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
}

let itemDictionary = itemsJSONString.parseJSONString as? NSDictionary
let itemsArray = itemDictionary?["PraxisItemsForSale"] as? NSArray

for praxisItem in itemsArray! {
    if let currentItem = praxisItem as? Dictionary<String, AnyObject>, let name = currentItem["name"] {
        print(name)
    }
}

