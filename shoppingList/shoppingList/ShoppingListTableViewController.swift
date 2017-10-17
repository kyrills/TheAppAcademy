import UIKit

class ShoppingListTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    //    var productDictionary = ["Red Bull" : #imageLiteral(resourceName: "RedBull"), "Bread" : #imageLiteral(resourceName: "Bread"), "Pasta" : #imageLiteral(resourceName: "Pasta"), "Cola" : #imageLiteral(resourceName: "Cola")]
    
    
    @IBOutlet weak var itemInput: UITextField!
    var productArray : [String] = []
    var items: String = ""
    var shoppingItemObject: [ShoppingItems] = []
    var selectedItem: ShoppingItems?
    //    var currentSelectedShopItem: Int
    
    
    var dictKeys: [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingItemObject = ShoppingItemService.shoppingListData()
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
        return shoppingItemObject.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celliD", for: indexPath)
        let storeObject = shoppingItemObject[indexPath.row]
        cell.textLabel?.text = storeObject.productName
        
        // Configure the cell...
        
        return cell
    }
    
    @IBAction func addItemButton(_ sender: Any) {
        if let textInput = itemInput.text{
            productArray.append(textInput)
            self.tableView.reloadData()
            itemInput.text = ""
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            productArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        items = productArray[indexPath.row]
        selectedItem = shoppingItemObject[indexPath.row]
        performSegue(withIdentifier: "detailView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailView"{
            let detailView = segue.destination as? detailViewController
            //            detailView?.shopItem = items
            detailView?.selectedDetailObject = selectedItem
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
