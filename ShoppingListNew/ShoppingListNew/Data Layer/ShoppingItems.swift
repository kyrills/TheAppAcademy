import Foundation
import UIKit

public class ShoppingItems{
    
    var productPrice: Double
    var productName: String
    var productImage: String
//    var productImage: ImageView
    
    init(productPrice: Double, productName: String, productImage: String) {
        self.productPrice = productPrice
        self.productName = productName
        self.productImage = productImage
    }
//    let url = URL(string: "https://domain.com/image.jpg")!
//    imageView.kf.setImage(with: url)
    
}
