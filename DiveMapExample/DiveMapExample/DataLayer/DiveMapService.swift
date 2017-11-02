import Foundation
import Alamofire

class DiveMapService {
    
    public static let sharedInstance = DiveMapService()
    private init(){}
    
    func getDiveDetail(id: String){
        Alamofire.request("http://api.divesites.com/?mode=detail&siteid=\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (jsonData) in
            if let json = jsonData.result.value as? NSDictionary{
                if let parsedArray = json["urls"] as? NSArray{
                    
                        if let data = parsedArray[0] as? NSDictionary,
                            let url = data["url"] as? String{
                            
                            let obj = DiveDetailProperties.init(url: url)
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationID.detailViewData),
                                                                                        object: self,
                                                                                        userInfo: ["data" : obj])
                        }
                    
                    }
                
            }
        }
    }
        
        func getDiveMapData(lat: Double, lng: Double, dist: Double){
            Alamofire.request("http://api.divesites.com/?mode=sites&lat=\(lat)&lng=\(lng)&dist=\(dist)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (jsonData) in
                if let json = jsonData.result.value as? NSDictionary{
                    if let usableStuff = json["sites"] as? NSArray{
                        var diveMapObject: [DiveMapDataProperties] = []
                        
                        for i in usableStuff{
                            if let data = i as? NSDictionary,
                                let name = data["name"] as? String,
                                let lat = data["lat"] as? String,
                                let lng = data["lng"] as? String,
                                let id = data["id"] as? String{
                                if let latDouble = Double(lat),
                                    let lngDouble = Double(lng){
                                    
                                    let obj = DiveMapDataProperties.init(name: name, id: id, longitude: lngDouble, latitude: latDouble)
                                    diveMapObject.append(obj)
                                }
                            }
                        }
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationID.initialDataRetreive),
                                                        object: self,
                                                        userInfo: ["data" : diveMapObject ])
                    }
                }
            }
        }
    
}
