import Foundation

class ShoppingItemsService{
    
    static func shoppingListData(){
        
        var shoppingArray: [ShoppingItems] = []
        
        let paprika = ShoppingItems.init(productPrice: 4.50, productName: "Paprika", productImage: #imageLiteral(resourceName: "bronn"))
        let beer = ShoppingItems.init(productPrice: 5.50, productName: "Beer", productImage: #imageLiteral(resourceName: "bronn"))
        let redbull = ShoppingItems.init(productPrice: 8.50, productName: "Red Bull", productImage: #imageLiteral(resourceName: "bronn"))
        let cheese = ShoppingItems.init(productPrice: 1.50, productName: "Cheese", productImage: #imageLiteral(resourceName: "bronn"))
        let ham = ShoppingItems.init(productPrice: 3.50, productName: "Ham", productImage: #imageLiteral(resourceName: "bronn"))
        let orange = ShoppingItems.init(productPrice: 8.50, productName: "Orange", productImage: #imageLiteral(resourceName: "bronn"))
        let apple = ShoppingItems.init(productPrice: 2.50, productName: "Apple", productImage: #imageLiteral(resourceName: "bronn"))
        

        
        shoppingArray = [paprika, beer, redbull, cheese, ham, orange, apple]
        
        let shoppingItemDictionary = [dictionaryKeys.shoppingData :shoppingArray]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationIDs.shoppingdataID),
                                        object: self,
                                        userInfo: shoppingItemDictionary)
    }
}
