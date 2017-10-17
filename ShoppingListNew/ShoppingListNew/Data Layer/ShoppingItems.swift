import Foundation
import UIKit

class ShoppingItems{
    
    var productPrice: Double
    var productName: String
    var productImage: UIImage
    
    init(productPrice: Double, productName: String, productImage: UIImage) {
        self.productPrice = productPrice
        self.productName = productName
        self.productImage = productImage
    }
}
