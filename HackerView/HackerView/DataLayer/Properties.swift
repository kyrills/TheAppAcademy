import Foundation

struct Properties: Hashable {
    
    static func ==(lhs: Properties, rhs: Properties) -> Bool {
        return lhs.objectID == rhs.objectID
    }
    
    var storyTitle: String
    var storyURL: String
    var objectID: Int
    var author: String
    var createdAt: Int
    var hashValue: Int { return self.objectID }
}
