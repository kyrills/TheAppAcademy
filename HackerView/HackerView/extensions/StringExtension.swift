import Foundation
extension String{
    func removeSpecialCharsFromString() -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890".characters)
        let tempString = (String(self.characters.filter {okayChars.contains($0) }))
        let urlString :String = tempString.replacingOccurrences(of: " ", with: "%20")
        return urlString
    }
}
