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
                let shopData = self.dictToObject(shoppingItem: shoppingItem)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationIDs.shoppingdataID),
                                                object: self,
                                                userInfo: [dictionaryKeys.shoppingData :shopData])
            }
        })
        
        ref.child("ShoppingItems").observe(.childAdded, with: { (snapshot) in
            if let data = snapshot.value as? NSDictionary,
                let obj = self.oneDictionaryToOneObject(item: data) {
                obj.id = snapshot.key
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationIDs.addedShoppingData),
                                                object: self,
                                                userInfo: [dictionaryKeys.shoppingData :obj])
            }
            
        })
//        ref.child("ShoppingItems").observe(.child)
        
    }
    func addShopItem(shopItem: ShoppingItems){
        let addDict = objToDictionary(shoppingItem: shopItem)
        ref.child("ShoppingItems").child(shopItem.id).setValue(addDict)
    }
    
    func removeShopItem(shopItem: ShoppingItems){
        ref.child("ShoppingItems").child(shopItem.id).removeValue()
    }
    
    func objToDictionary(shoppingItem: ShoppingItems) -> Dictionary<String, Any>{
        var ObjectDict = Dictionary<String, Any>.init()
        ObjectDict[dataStrings.productName] = shoppingItem.productName
        ObjectDict[dataStrings.productImage] = shoppingItem.productImage
        ObjectDict[dataStrings.productPrice] = shoppingItem.productPrice
        ObjectDict[dataStrings.productWeight] = shoppingItem.productWeight
        ObjectDict[dataStrings.id] = shoppingItem.id
        return ObjectDict
    }
    
    
    func dictToObject(shoppingItem: NSDictionary) -> [ShoppingItems] {
        var shopitems: [ShoppingItems] = []
        
        for key in shoppingItem.keyEnumerator() {
            if let item = shoppingItem[key] as? NSDictionary,
                let itemObj = oneDictionaryToOneObject(item: item) {
                itemObj.id = key as! String
                shopitems.append(itemObj)
            }
        }
        return shopitems
    }
    
    func oneDictionaryToOneObject(item : NSDictionary) -> ShoppingItems? {
        if let productName = item["productName"] as? String,
            let productPrice = item["productPrice"] as? Double,
            let productImage = item["productImage"] as? String,
            let productWeight = item["productWeight"] as? Double{
            let shoppingitemObject = ShoppingItems.init(productPrice: productPrice, productName: productName, productImage: productImage, productWeight: productWeight)
            return shoppingitemObject
        } else {
            return nil
        }
    }
    
//    func dictToShoppingItem(dict: NSDictionary) -> [ShoppingItems] {
//        var shopItems: [ShoppingItems] = []
//
//        for key in dict.keyEnumerator() {
//
//            if let item = dict[key] as? NSDictionary,
//                let productName = item["productName"] as? String,
//                let productPrice = item["productPrice"],
//                let productImage = item["productImage"],
//                let productWeight = item["productWeight"]{
//                let shoppingitemObject = ShoppingItems.init(productPrice: productPrice as! Double, productName: productName, productImage: productImage as! String, productWeight: productWeight as! Double)
//                shopItems.append(shoppingitemObject)
//            }
//
//        }
//
//        return shopItems
//    }
}
