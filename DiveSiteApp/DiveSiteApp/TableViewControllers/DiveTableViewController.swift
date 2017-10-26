import UIKit

class DiveTableViewController: UITableViewController {
    var diveItemObject: [DiveItems] = []
    var selectedTableViewItem: DiveItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(DiveTableViewController.notifyObservers),
                                               name: NSNotification.Name(rawValue: notificationID.diveDataAdded),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(DiveTableViewController.addingObservers),
                                               name: NSNotification.Name(rawValue: notificationID.addedData),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(DiveTableViewController.changedObservers),
                                               name: NSNotification.Name(rawValue: notificationID.changedData),
                                               object: nil)
        
        
        let divingCell = UINib.init(nibName: "ShoppingCell", bundle: nil)
        self.tableView.register(divingCell, forCellReuseIdentifier: tableCellID.divingCellID)
        
        DiveSiteService.reference.getDiveSiteData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diveItemObject.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempDiveObject = diveItemObject[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID.divingCellID, for: indexPath) as! ShoppingCell

        cell.cellNameLabel.text = tempDiveObject.name
        return cell
    }
    
    @objc func notifyObservers(notification: NSNotification) {
        var diveItemDict = notification.userInfo as! Dictionary<String , [DiveItems]>
        diveItemObject = diveItemDict[databaseKeys.dataKey]!
        self.tableView.reloadData()
    }
    
    @objc func addingObservers(notification: NSNotification) {
        var diveItemDict = notification.userInfo as? Dictionary<String, DiveItems>
        let one = diveItemDict![databaseKeys.dataKey]
        diveItemObject.append(one!)
        self.tableView.reloadData()
    }
    
    @objc func changedObservers(notification: NSNotification) {
        
        if let diveItemDict = notification.userInfo as? Dictionary<String , DiveItems> {
            let changeDiveItemObject = diveItemDict[databaseKeys.dataKey]
            self.diveItemObject = self.diveItemObject.map({ (item) -> DiveItems in
                if changeDiveItemObject?.id == item.id{
                    return changeDiveItemObject!
                }
                else{
                    return item
                }
            })
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTableViewItem = diveItemObject[indexPath.row]
        performSegue(withIdentifier: segues.detailTableViewSegue, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DiveSiteService.reference.removeDiveItem(diveItem: self.diveItemObject[indexPath.row])
            diveItemObject.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  segues.detailTableViewSegue{
            let detailView = segue.destination as? DiveDetailTableViewController
            detailView?.selectedDetailObject = selectedTableViewItem
        }
    }
    
    @IBAction func addShoppingItem(_ sender: Any) {
        let alert = UIAlertController(title: "Dive Item", message: "Add new stuff.", preferredStyle: .alert)
        
        alert.addTextField { (name) in
            name.placeholder = "Name"
        }
        alert.addTextField { (diveLocation) in
            diveLocation.placeholder = "Location"
        }
        alert.addTextField{(depthMetres) in
            depthMetres.keyboardType = .numberPad
            depthMetres.placeholder = "Depth"
        }
        alert.addTextField{(ocean) in
            ocean.placeholder = "ocean"
        }
        alert.addTextField{(imageURLS) in
            imageURLS.placeholder = "Image URL"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            if let name = alert?.textFields?[0].text,
                let diveLocation = alert?.textFields?[1].text,
                let depthMetres = alert?.textFields?[2].text,
                let ocean = alert?.textFields?[3].text,
                let imageURLS = alert?.textFields?[4].text,
                let depthMetresInt = Int(depthMetres){
                let id = NSUUID().uuidString
                let diveItem = DiveItems.init(name: name, id: id, diveLocation: diveLocation, depthMetres: depthMetresInt, ocean: ocean, imageURLS: [imageURLS])
                DiveSiteService.reference.addDiveItem(diveItem: diveItem)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }


}
