import Foundation

class ShoppingItemService {
    
    static func shoppingListData() -> [ShoppingItems] {
        
        var shopping: [ShoppingItems] = []
        let paprika = ShoppingItems.init(productPrice: 4.50, productName: "Paprika", productPhoto: #imageLiteral(resourceName: "bronn"))
        let beer = ShoppingItems.init(productPrice: 5.50, productName: "Beer", productPhoto: #imageLiteral(resourceName: "bronn"))
        let energy = ShoppingItems.init(productPrice: 8.50, productName: "Red Bull", productPhoto: #imageLiteral(resourceName: "RedBull"))
        let cheese = ShoppingItems.init(productPrice: 1.50, productName: "Cheese", productPhoto: #imageLiteral(resourceName: "bronn"))
        let ham = ShoppingItems.init(productPrice: 3.50, productName: "Ham", productPhoto: #imageLiteral(resourceName: "bronn"))
        let orange = ShoppingItems.init(productPrice: 8.50, productName: "Orange", productPhoto: #imageLiteral(resourceName: "bronn"))
        let apple = ShoppingItems.init(productPrice: 2.50, productName: "Apple", productPhoto: #imageLiteral(resourceName: "bronn"))
        
        shopping.append(paprika)
        shopping.append(beer)
        shopping.append(energy)
        shopping.append(ham)
        shopping.append(cheese)
        shopping.append(orange)
        shopping.append(apple)
        
        return shopping
    }
}
