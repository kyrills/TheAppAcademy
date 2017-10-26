import Foundation
import Firebase
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage
import SVProgressHUD

class ShoppingItemsService {
    var shoppingArray: [ShoppingItems] = []
    public static let sharedInstance = ShoppingItemsService()  // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    
    private init() { // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    }
    
    var ref: DatabaseReference!
    
    public func getShoppingListData() {
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value , with: { (snapshot) in
            if let data = snapshot.value as? NSDictionary,
                let shoppingItem = data["ShoppingItems"] as? NSDictionary {
                let shopData = self.dictToObject(shoppingItem: shoppingItem)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationIDs.shoppingdataID),
                                                object: self,
                                                userInfo: [dictionaryKeys.shoppingData :shopData])
            }
        })
        
        ref.child("ShoppingItems").observe(.childAdded, with: { (snapshot) in
            if let data = snapshot.value as? NSDictionary,
                let obj = self.oneDictionaryToOneObject(item: data) {
                obj.id = snapshot.key
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationIDs.addedShoppingData),
                                                object: self,
                                                userInfo: [dictionaryKeys.shoppingData :obj])
            }
        })
        
        ref.child("ShoppingItems").observe(.childChanged, with: { (snapshot) in
            if let data = snapshot.value as? NSDictionary,
                let obj = self.oneDictionaryToOneObject(item: data){
                obj.id = snapshot.key
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationIDs.changedShoppingData),
                                                object: self,
                                                userInfo: [dictionaryKeys.shoppingData :obj])
            }
        })
    }
    
    func addShopItem(shopItem: ShoppingItems){
        let addDict = objToDictionary(shoppingItem: shopItem)
        ref.child("ShoppingItems").child(shopItem.id).setValue(addDict)
    }
    
    func removeShopItem(shopItem: ShoppingItems){
        ref.child("ShoppingItems").child(shopItem.id).removeValue()
    }
    
    func updateShopItem(shopItem: ShoppingItems){
        let updated = objToDictionary(shoppingItem: shopItem)
        ref.child("ShoppingItems").child(shopItem.id).updateChildValues(updated)
    }
    
    func objToDictionary(shoppingItem: ShoppingItems) -> Dictionary<String, Any>{
        var ObjectDict = Dictionary<String, Any>.init()
        ObjectDict[dataStrings.productName] = shoppingItem.productName
        ObjectDict[dataStrings.productImage] = shoppingItem.productImage
        ObjectDict[dataStrings.productPrice] = shoppingItem.productPrice
        ObjectDict[dataStrings.productWeight] = shoppingItem.productWeight
        ObjectDict[dataStrings.id] = shoppingItem.id
        return ObjectDict
    }
    
    
    func dictToObject(shoppingItem: NSDictionary) -> [ShoppingItems] {
        var shopitems: [ShoppingItems] = []
        
        for key in shoppingItem.keyEnumerator() {
            if let item = shoppingItem[key] as? NSDictionary,
                let itemObj = oneDictionaryToOneObject(item: item) {
                itemObj.id = key as! String
                shopitems.append(itemObj)
            }
        }
        return shopitems
    }
    
    func oneDictionaryToOneObject(item : NSDictionary) -> ShoppingItems? {
        if let productName = item["productName"] as? String,
            let productPrice = item["productPrice"] as? Double,
            let productImage = item["productImage"] as? String,
            let productWeight = item["productWeight"] as? Double{
            let shoppingitemObject = ShoppingItems.init(productPrice: productPrice, productName: productName, productImage: productImage, productWeight: productWeight)
            return shoppingitemObject
        } else {
            return nil
        }
    }
    
    func uploadImage(image: UIImage, imageName: String){
        
        let storageRef = Storage.storage().reference()
        let imagesRef = storageRef.child(imageName)
        let data = UIImageJPEGRepresentation(image, 0.1)
        // Upload file and metadata to the object ‘images/mountains.jpg’
        // Create the file metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Upload file and metadata to the object 'images/mountains.jpg'
//        let uploadTask = storageRef.putFile(from: localFile, metadata: metadata)
        let uploadTask = imagesRef.putData(data!, metadata: metadata)

        // Listen for state changes, errors, and completion of the upload.
        uploadTask.observe(.resume) { snapshot in
            // Upload resumed, also fires when the upload starts
        }
        
        uploadTask.observe(.pause) { snapshot in
            // Upload paused
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            SVProgressHUD.showProgress(Float(percentComplete), status: String(percentComplete))
        }
        
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully
            snapshot.reference.downloadURL(completion: { (url, error) in
                self.ref.child("ShoppingItems").observe(.childAdded, with: { (snapshot) in
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:notificationIDs.imageURL),
                                                        object: self,
                                                        userInfo: [notificationKeys.imageURL : url!])
            SVProgressHUD.dismiss()
                })
            })
        }
        
        
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as? NSError {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
        }
        }
    }

