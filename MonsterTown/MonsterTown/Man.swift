
import Foundation

class Man: Human{
    override func talk(word: String) {
        super.talk(word: "The man \(word)")
    }
}
