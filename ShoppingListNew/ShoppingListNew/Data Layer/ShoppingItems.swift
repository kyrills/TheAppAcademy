import Foundation
import UIKit

public class ShoppingItems{
    
    var productPrice: Double
    var productName: String
    var productImage: String
    var productWeight: Double
    var id = NSUUID().uuidString
    
    init(productPrice: Double, productName: String, productImage: String, productWeight: Double) {
        self.productPrice = productPrice
        self.productName = productName
        self.productImage = productImage
        self.productWeight = productWeight
    }
}
