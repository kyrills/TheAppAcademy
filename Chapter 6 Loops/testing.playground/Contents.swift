import UIKit

func toNato(_ words: String) -> String{
    var natoAlphabet: Dictionary<Character, String> = ["a": "Alfa", "b": "Bravo", "c" : "Charlie", "d" : "Delta",
                                                       "e": "Echo", "f": "Foxtrot", "g": "Golf", "h": "Hotel",
                                                       "i": "India", "j": "Juliet", "k": "Kilo", "l": "Lima",
                                                       "m": "Mike", "n": "November", "o": "Oscar", "p": "Papa",
                                                       "q": "Quebec", "r": "Romeo", "s": "Sierra", "t": "Tango",
                                                       "u": "Uniform", "v": "Victor", "w": "Whiskey", "x": "Xray",
                                                       "y": "Yankee", "z": "Zulu"]
    
    var emptyString: String = ""
    var noSpaces = String(words.characters.filter { !" \n\t\r".characters.contains($0) }).lowercased()
    for letter in noSpaces.characters {
        if let test = natoAlphabet[letter]{
            emptyString.append(test)
            emptyString.append(" ")

        } else {
            emptyString.append(letter)
        }
    }
    return emptyString.trimmingCharacters(in: .whitespacesAndNewlines)
}
print(toNato("Did not ? see that coming"))
