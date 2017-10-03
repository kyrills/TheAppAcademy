import UIKit

var natoAlphabet: Dictionary<String, String> = ["a": "Alpha", "b": "Bravo", "c" : "Charlie", "d" : "Delta",
                                                "e": "Echo", "f": "Foxtrot", "g": "Gamma", "h": "Hotel",
                                                "i": "India", "j": "Juliet", "k": "Kilo", "l": "Lima",
                                                "m": "Mike", "n": "November", "o": "Oscar", "p": "Papa",
                                                "q": "Quebec", "r": "Romeo", "s": "Sierra", "t": "Tango",
                                                "u": "Uniform", "v": "Victor", "w": "Whiskey", "x": "Xray",
                                                "y": "Yankee", "z": "Zulu"]

func toNato(_ words: String) -> String{
    for letter in words.characters
{
        let temp: String = String(letter)
        
        print("\(String(describing: natoAlphabet[temp]))")
    }
    return ""
}

toNato("Hey man how are you!".lowercased())
