import Foundation
import UIKit

public class ShoppingItems{
    
    var productPrice: Double
    var productName: String
//    var productImage: UIImage
    var productImage: String
    
    init(productPrice: Double, productName: String, productImage: String) {
        self.productPrice = productPrice
        self.productName = productName
        self.productImage = productImage
    }
}
