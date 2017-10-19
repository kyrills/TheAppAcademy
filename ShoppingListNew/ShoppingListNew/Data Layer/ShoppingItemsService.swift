import Foundation
import Firebase
import FirebaseCore
import FirebaseDatabase


class ShoppingItemsService{
    var shoppingArray: [ShoppingItems] = []
    public static let sharedInstance = ShoppingItemsService()  // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    
    private init() { // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    }
    
    var ref: DatabaseReference!
    
    public func getShoppingListData() {
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value , with: { (snapshot) in
            if let data = snapshot.value as? NSDictionary,
                let shoppingItem = data["ShoppingItems"] as? NSDictionary {
                print(data)
                var shopItems: [ShoppingItems] = []
                
                for key in shoppingItem.keyEnumerator() {
                    
                    if let item = shoppingItem[key] as? NSDictionary,
                        let productName = item["productName"] as? String,
                        let productPrice = item["productPrice"],
                        let productImage = item["productImage"]{
                        let shoppingitemObject = ShoppingItems.init(productPrice: productPrice as! Double, productName: productName, productImage: productImage as! String)
                        shopItems.append(shoppingitemObject)
                        print(shopItems)
                    }
                    
                }
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationIDs.shoppingdataID),
                                                object: self,
                                                userInfo: [dictionaryKeys.shoppingData :shopItems])
            }
        })
    }
}

//                    if let status = itemDictionary?["status"] as? Bool,
//                        let message = itemDictionary? ["message"] as? String{
//                        if status {
//                            for item in (itemsArray)!{
//                                if let currentItem = item as? Dictionary<String, AnyObject>,
//                                    let name = currentItem["name"],
//                                    let country = currentItem["country"],
//                                    let depth = currentItem["depthMetresString"],
//                                    let visibility = currentItem["visibilityMetresString"]{

//                }
//            }
//        })
//
//    }

//    public func getShoppingListData(){
//        ref = Database.database().reference()
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            if let data = snapshot.value as? NSDictionary,
//                let shoppingItem = data ["ShoppingItems"] as? NSDictionary {
//                for key in shoppingItem.keyEnumerator(){
//                    print(key)
//
//
//                    if let currentItem = shoppingItem[key] as? NSDictionary,
//                        let productName = currentItem[dataStrings.productName] as? String,
//                        let productPrice = currentItem[dataStrings.productPrice],
//                        let productImage = currentItem[dataStrings.productImage] as? String{
//                            let shoppingItemObject = ShoppingItems.init(productPrice: productPrice as! Double,
//                                                                        productName: productName as! String,
//                                                                        productImage: productImage as! UIImage)
//                        print(shoppingItemObject)

//    static func shoppingListData(){
//
//        var shoppingArray: [ShoppingItems] = []
//
//        let paprika = ShoppingItems.init(productPrice: 4.50, productName: "Paprika", productImage: #imageLiteral(resourceName: "bronn"))
//        let beer = ShoppingItems.init(productPrice: 5.50, productName: "Beer", productImage: #imageLiteral(resourceName: "bronn"))
//        let redbull = ShoppingItems.init(productPrice: 8.50, productName: "Red Bull", productImage: #imageLiteral(resourceName: "bronn"))
//        let cheese = ShoppingItems.init(productPrice: 1.50, productName: "Cheese", productImage: #imageLiteral(resourceName: "bronn"))
//        let ham = ShoppingItems.init(productPrice: 3.50, productName: "Ham", productImage: #imageLiteral(resourceName: "bronn"))
//        let orange = ShoppingItems.init(productPrice: 8.50, productName: "Orange", productImage: #imageLiteral(resourceName: "bronn"))
//        let apple = ShoppingItems.init(productPrice: 2.50, productName: "Apple", productImage: #imageLiteral(resourceName: "bronn"))
//
//
//
//        shoppingArray = [paprika, beer, redbull, cheese, ham, orange, apple]
//
//            let shoppingItemDictionary = [dictionaryKeys.shoppingData :shoppingArray]
//
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationIDs.shoppingdataID),
//                                        object: self,
//                                        userInfo: shoppingItemDictionary)
//    }


//}

