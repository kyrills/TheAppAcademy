import UIKit
import Kingfisher

class DiveDetailTableViewController: UITableViewController {

    var selectedDetailObject: DiveItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let detailCell = UINib.init(nibName: "ShoppingDetailCell", bundle: nil)
        self.tableView.register(detailCell, forCellReuseIdentifier: "ShoppingDetailCellID")

    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingDetailCellID", for: indexPath) as! ShoppingDetailCell

        cell.nameLabel.text = selectedDetailObject?.name
        cell.diveLocation.text = selectedDetailObject?.diveLocation
        cell.oceanLabel.text = selectedDetailObject?.ocean

        let url = URL(string:(selectedDetailObject?.imageURLS[0])!)
        cell.cellImage.kf.setImage(with: url)
        
        if let depth = selectedDetailObject?.depthMetres{
            cell.depthMetres.text = "\(depth)"
        }
        // Configure the cell...

        return cell
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        
        let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! ShoppingDetailCell
        selectedDetailObject?.name = cell.nameLabel.text!
        selectedDetailObject?.diveLocation = cell.diveLocation.text!
        selectedDetailObject?.ocean = cell.oceanLabel.text!
        if let depth = Int(cell.depthMetres.text!){
            selectedDetailObject?.depthMetres = depth
            DiveSiteService.reference.updateDiveItem(diveItem: selectedDetailObject!)
        }
//        print(selectedDetailObject)
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
