import Foundation
import UIKit

class ShoppingItems{
    
    var productPrice: Double
    var productName: String
    var productPhoto: UIImage
    
    init(productPrice: Double, productName: String, productPhoto: UIImage){
        self.productPrice = productPrice
        self.productName = productName
        self.productPhoto = productPhoto
    
    }
    
}
