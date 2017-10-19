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
    
    @objc func notifyObservers(notification: NSNotification) {
        var shopItemDict = notification.userInfo as! Dictionary<String , [ShoppingItems]>
        shoppingItemObject = shopItemDict[dictionaryKeys.shoppingData]!
        self.tableView.reloadData()
    }
}

