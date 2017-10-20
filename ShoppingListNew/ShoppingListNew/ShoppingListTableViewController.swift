import UIKit

class ShoppingListTableViewController: UITableViewController {
    
    var shoppingItemObject: [ShoppingItems] = []
    var selectedItem: ShoppingItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ShoppingListTableViewController.notifyObservers),
                                               name: NSNotification.Name(rawValue: notificationIDs.shoppingdataID),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ShoppingListTableViewController.addingObservers),
                                               name: NSNotification.Name(rawValue: notificationIDs.addedShoppingData),
                                               object: nil)
        
        ShoppingItemsService.sharedInstance.getShoppingListData()
        
        let shoppingCell = UINib.init(nibName: "ShoppingCell", bundle: nil)
        self.tableView.register(shoppingCell, forCellReuseIdentifier: tableCellID.shoppingCellId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItemObject.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeObject = shoppingItemObject[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID.shoppingCellId,
                                                 for: indexPath) as! ShoppingCell
        cell.cellNameLabel.text = storeObject.productName
        print(storeObject.productName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ShoppingItemsService.sharedInstance.removeShopItem(shopItem: self.shoppingItemObject[indexPath.row])
            shoppingItemObject.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }}
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = shoppingItemObject[indexPath.row]
        performSegue(withIdentifier: segues.detailTableViewSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  segues.detailTableViewSegue{
            let detailView = segue.destination as? DetailTableViewController
            detailView?.selectedDetailObject = selectedItem
        }
    }
    
    @IBAction func addShoppingItem(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "New Shopping Item", message: "Enter a new shopping Item", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "The New item"
        }
        alert.addTextField { (priceField) in
            priceField.keyboardType = .numberPad
            priceField.placeholder = "The New Price"
        }
        alert.addTextField{(weightField) in
            weightField.keyboardType = .numberPad
            weightField.placeholder = "Weight"
        }
        alert.addTextField{(imageField) in
            imageField.placeholder = "Image URL"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            if let textField = alert?.textFields?[0].text,
                let priceField = alert?.textFields?[1].text,
                let weightField = alert?.textFields?[2].text,
                let imageField = alert?.textFields?[3].text,
                let priceDouble = Double(priceField),
                let weightDouble = Double(weightField){
                let shopItem = ShoppingItems.init(productPrice: priceDouble, productName: textField, productImage: imageField, productWeight: weightDouble)
                ShoppingItemsService.sharedInstance.addShopItem(shopItem: shopItem)
                print("Text field: \(textField)")
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func notifyObservers(notification: NSNotification) {
        var shopItemDict = notification.userInfo as! Dictionary<String , [ShoppingItems]>
        shoppingItemObject = shopItemDict[dictionaryKeys.shoppingData]!
        self.tableView.reloadData()
    }
    
    @objc func addingObservers(notification: NSNotification) {
        if let shopItemDict = notification.userInfo as? Dictionary<String , ShoppingItems>{
            let one = shopItemDict[dictionaryKeys.shoppingData]
            shoppingItemObject.append(one!)
            self.tableView.reloadData()
            print(shoppingItemObject)
        }
    }
}

