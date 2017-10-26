import UIKit
import Kingfisher

class DetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var selectedDetailObject: ShoppingItems?

    override func viewDidLoad() {
        super.viewDidLoad()

        let detailCell = UINib.init(nibName: "ShoppingDetailCell", bundle: nil)
        self.tableView.register(detailCell, forCellReuseIdentifier: tableCellID.shoppingDetailCellID)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(DetailTableViewController.notificationImageURL),
                                               name: NSNotification.Name(rawValue: notificationIDs.imageURL),
                                               object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(cameraButton(_:)))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID.shoppingDetailCellID, for: indexPath) as! ShoppingDetailCell
        
        let a:Double = (selectedDetailObject?.productPrice)!
        let b:String = String(format:"%.2f", a)
        
        cell.nameLabel.text = selectedDetailObject?.productName
        cell.priceLabel.text = b
        
        if let weight = selectedDetailObject?.productWeight{
            cell.weightLabel.text = "\(weight)"
        }
        
        let url = URL(string: (selectedDetailObject?.productImage)!)
        cell.cellImage.kf.setImage(with: url)
        
        return cell
    }
    
    @objc func notificationImageURL(notification: NSNotification){
        let imageDict = notification.userInfo as! Dictionary<String , URL>
        let urlString = imageDict[notificationKeys.imageURL]
        self.selectedDetailObject?.productImage = (urlString?.absoluteString)!
        ShoppingItemsService.sharedInstance.updateShopItem(shopItem: selectedDetailObject!)

    }
    
    override func viewWillDisappear(_ animated: Bool) {

        super .viewWillDisappear(animated)
        
        let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! ShoppingDetailCell
        selectedDetailObject?.productName = cell.nameLabel.text!
        if let price = Double(cell.priceLabel.text!), let weight = Double(cell.weightLabel.text!) {
            selectedDetailObject?.productPrice = price
            selectedDetailObject?.productWeight = weight
        }
        ShoppingItemsService.sharedInstance.updateShopItem(shopItem: selectedDetailObject!)
    }
    
    @objc func cameraButton(_ sender: UIButton) {
            let imagePicker = UIImagePickerController()
            let alert = UIAlertController(title: "Choose one of the following:", message: "", preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Gallery",
                                          style: .default,
                                          handler: { action in
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)

            }))
            
            alert.addAction(UIAlertAction(title: "Camera",
                                          style: .default,
                                          handler: { action in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                } else{
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self

                    self.present(imagePicker, animated: true, completion: nil)
                                            }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default , handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let cell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? ShoppingDetailCell
    
        let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        let imagePath =  imageURL.path!
        
        let imageFile = info[UIImagePickerControllerOriginalImage] as! UIImage

        cell?.cellImage.image = imageFile
        
        ShoppingItemsService.sharedInstance.uploadImage(image: imageFile, imageName: imagePath )
        
        self.dismiss(animated: true, completion: nil);
    }
}
