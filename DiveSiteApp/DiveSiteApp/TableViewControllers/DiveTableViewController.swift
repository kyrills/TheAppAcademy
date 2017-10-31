import UIKit

class DiveTableViewController: UITableViewController {
    var diveItemObject: [DiveItems] = []
    var selectedTableViewItem: DiveItems?
    let transition = PopAnimator()

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

    @IBAction func OpenPopupView(_ sender: Any){
        let popupStoryboard: UIStoryboard = UIStoryboard(name: "PopupVC", bundle: nil)
        let popupVC = popupStoryboard.instantiateViewController(withIdentifier: "PopupVCID") as! PopupViewController
        popupVC.transitioningDelegate = self
        present(popupVC, animated: true)
        
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
}

extension DiveTableViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        self.transition.presenting = true
        return transition
    }
}

