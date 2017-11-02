import Foundation
import Alamofire

class HackerNewsService{
    
    public static let sharedInstance = HackerNewsService()
    private init(){}
    
    var hackingObject: [Properties] = []
    
    
    func getTheHackerNews(_ cnt: Int, _ query: String) {
        Alamofire.request("https://hn.algolia.com/api/v1/search_by_date?query=\(query)?page=\(cnt)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (jsonData) in
            if let json = jsonData.result.value as? NSDictionary{
                if let usableStuff = json["hits"] as? NSArray{
                    for i in usableStuff{
                        if let data = i as? NSDictionary,
                            let title = data["story_title"] as? String,
                            let author = data["author"] as? String,
                            let storyURL = data["story_url"] as? String,
                            let id = data["objectID"] as? String,
                            let created = data["created_at_i"] as? Int,
                            let intID = Int(id){
                            
                            print(query)
                            
                            let obj = Properties.init(storyTitle: title, storyURL: storyURL, objectID: intID, author: author, createdAt: created)
                            self.hackingObject.append(obj)
                            
                        }
                    }
                    self.hackingObject = self.uniq(source: self.hackingObject)
                    self.hackingObject = self.hackingObject.sorted(by: { (c, d) -> Bool in
                        return c.createdAt > d.createdAt
                        
                    })
                }
                
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationID.productsAdded),
                                            object: self,
                                            userInfo: [DictKeys.dictKey : self.hackingObject])
            }
        }
    }
    func uniq<S: Sequence, E: Hashable>(source: S) -> [E] where E==S.Iterator.Element {
        var seen: [E:Bool] = [:]
        return source.filter({ (v) -> Bool in
            return seen.updateValue(true, forKey: v) == nil
        })
    }
    
    func emptyStuff(_ cnt: Int, _ query: String){
        hackingObject = []
        getTheHackerNews(cnt, query)
    }
    
}


