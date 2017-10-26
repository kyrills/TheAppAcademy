import Foundation
import Firebase

class DiveSiteService{
    var diveSiteData: [DiveItems] = []
    
    public static let reference = DiveSiteService()
    private init(){}
    
    var ref: DatabaseReference!
    
    public func getDiveSiteData(){
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value , with: { (snapshot) in
            if let dict = snapshot.value as? NSDictionary,
                let data = dict[databaseKeys.dataKey] as? [String: Any]{
                var diveItemArray: [DiveItems] = []

                for (key, dict) in data {
                    if var itemObj = self.dictionaryToOneObject(dict: dict as! NSDictionary) {
                        itemObj.id = key
                        print(key)
                        print(itemObj.id)
                        diveItemArray.append(itemObj)
                    }
                    
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationID.diveDataAdded),
                                                object: self,
                                                userInfo: [databaseKeys.dataKey : diveItemArray])
            }
        })
        
        ref.child(databaseKeys.dataKey).observe(.childAdded, with: { (snapshot) in
            if let data = snapshot.value as? NSDictionary,
                var obj = self.dictionaryToOneObject(dict: data) {
                obj.id = snapshot.key
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationID.addedData),
                                                object: self,
                                                userInfo: [databaseKeys.dataKey :obj])
            }
    })
        
        ref.child(databaseKeys.dataKey).observe(.childChanged, with: { (snapshot) in
            if let data = snapshot.value as? NSDictionary,
                var obj = self.dictionaryToOneObject(dict: data){
                obj.id = snapshot.key
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationID.changedData),
                                                object: self,
                                                userInfo: [databaseKeys.dataKey :obj])
            }
        })
        
    }
    
    func addDiveItem(diveItem: DiveItems){
        let addDict = objToDictionary(diveItem: diveItem)
        ref.child(databaseKeys.dataKey).child(diveItem.id).setValue(addDict)
    }
    func removeDiveItem(diveItem: DiveItems){
    ref.child(databaseKeys.dataKey).child(diveItem.id).removeValue()
    }
    func updateDiveItem(diveItem: DiveItems){
        let updated = objToDictionary(diveItem: diveItem)
        ref.child(databaseKeys.dataKey).child(diveItem.id).updateChildValues(updated!)
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
    
    
    func objToDictionary(diveItem: DiveItems) -> [String: Any]? {
        let encoder = JSONEncoder()
        if #available(iOS 11.0, *){
            encoder.outputFormatting = .sortedKeys
        }
        do{
            let encodedDiveItem = try encoder.encode(diveItem)
            let dict = try JSONSerialization.jsonObject(with: encodedDiveItem, options: []) as? [String: Any]
            
            return dict as [String: Any]?
        } catch {
            return [:]
        }
    }
}
