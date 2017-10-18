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
        ShoppingItemsService.shoppingListData()

        let shoppingCell = UINib.init(nibName: "ShoppingCell", bundle: nil)
        self.tableView.register(shoppingCell, forCellReuseIdentifier: tableCellID.shoppingCellId)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID.shoppingCellId,
//                                                 for: indexPath) as! ShoppingCell
//        cell.cellNameLabel =
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItemObject.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID.cellID, for: indexPath)
        let storeObject = shoppingItemObject[indexPath.row]
//        cell.textLabel?.text = storeObject.productName
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID.shoppingCellId,
                                                 for: indexPath) as! ShoppingCell
        cell.cellNameLabel.text = storeObject.productName
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0{
//            return 100
//        }
//        return 44
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = shoppingItemObject[indexPath.row]
        performSegue(withIdentifier: segues.detailViewSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segues.detailViewSegue{
            let detailView = segue.destination as? DetailViewController
            detailView?.selectedDetailObject = selectedItem
        }
    }
    
    @objc func notifyObservers(notification: NSNotification) {
        var shopItemDict = notification.userInfo as! Dictionary<String , [ShoppingItems]>
        shoppingItemObject = shopItemDict[dictionaryKeys.shoppingData]!
    }
}

