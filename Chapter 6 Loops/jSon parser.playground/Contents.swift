import UIKit

//Here is the escaped string...just imagine this is our data retrieved from a server! Like for real!!!
var itemsJSONString = "{\"status\":true,\"message\":\"Success!\",\"date\":1507038878597,\"data\":[{\"_id\":\"59d1f9590cf3a2ea732ff73d\",\"geo\":[0,0],\"lng\":0,\"lat\":0,\"coordinatesNeedCorrection\":true,\"name\":\"Sand Harbor \",\"url\":\"\",\"__v\":0,\"siteVerified\":false,\"country\":\"USA\",\"region\":null,\"diveLocation\":null,\"description\":null,\"experienceReq\":null,\"depthMetresString\":10,\"visibilityMetresString\":8,\"currents\":null,\"access\":null,\"videoURLS\":[],\"imageURLS\":[],\"imageThumbURLS\":[],\"marinelifeArray\":[],\"typeOfDivingArray\":[]}]}"


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
let itemsArray = itemDictionary?["data"] as? NSArray
//let itemsArray = itemDictionary?["status"] as? NSArray
if let status = itemDictionary?["status"] as? Bool,
    let message = itemDictionary? ["message"] as? String{
    if status == true {
        for item in (itemsArray)!{
        if let currentItem = item as? Dictionary<String, AnyObject>,
            let name = currentItem["name"],
            let country = currentItem["country"],
            let depth = currentItem["depthMetresString"],
            let visibility = currentItem["visibilityMetresString"]{
            print("\(name) is located in the \(country). It has a depth of \(depth) meters and a visibility of \(visibility) meters.")
        }
        }
    } else {
        print(message)
    }
//    print(status)
} else {
    print("Something went wrong!")
}
