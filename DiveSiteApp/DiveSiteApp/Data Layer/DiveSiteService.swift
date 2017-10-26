import Foundation
import Firebase

class DiveSiteService{
    var diveSiteData: [DiveItems] = []
    
    public static let reference = DiveSiteService()
    private init(){}
    
    var ref: DatabaseReference!
    var diveItemArray: [DiveItems] = []
    
    public func getDiveSiteData(){
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value , with: { (snapshot) in
            if let dict = snapshot.value as? NSDictionary,
                let data = dict["data"] as? NSArray{
                for dict in data {
                    self.dictionaryToObject(dataDict: dict as! NSDictionary)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationID.diveDataAdded),
                                                object: self,
                                                userInfo: [databaseKeys.dataKey : self.diveItemArray])
            }
        })
        
        ref.child("data").observe(.childAdded, with: { (snapshot) in
            if let data = snapshot.value as? NSDictionary,
                var obj = self.dictionaryToOneObject(dict: data) {
                obj.id = snapshot.key
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationID.addedData),
                                                object: self,
                                                userInfo: [databaseKeys.dataKey :obj])
            }
    })
}
    
    func dictionaryToObject(dataDict: NSDictionary ) {
        if let itemObj = dictionaryToOneObject(dict: dataDict as NSDictionary) {
            diveItemArray.append(itemObj)
        }
    }
    
    func dictionaryToOneObject(dict: NSDictionary) -> DiveItems?{
        let decoder = JSONDecoder()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let item = try decoder.decode(DiveItems.self, from: jsonData)
            return item
            
        } catch {
            return nil
        }
        
    }
}
