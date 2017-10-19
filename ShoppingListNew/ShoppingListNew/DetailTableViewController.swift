import UIKit
import Kingfisher

class DetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var selectedDetailObject: ShoppingItems?

    override func viewDidLoad() {
        super.viewDidLoad()

        let detailCell = UINib.init(nibName: "ShoppingDetailCell", bundle: nil)
        self.tableView.register(detailCell, forCellReuseIdentifier: tableCellID.shoppingDetailCellID)
        
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
        
//        let url = URL(string: (selectedDetailObject?.productImage)!)
        let url = URL(string: (selectedDetailObject?.productImage)!)
        cell.cellImage.kf.setImage(with: url)
//        cell.cellImage.image = selectedDetailObject?.productImage
        
        return cell
    }
}
