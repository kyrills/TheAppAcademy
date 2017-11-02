import UIKit

class HackerNewsTableViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    var newsObject: [Properties] = []
    var selectedItem: Properties?
    var searchController: UISearchController!
    var cnt = 1
    var query = "ios"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(HackerNewsTableViewController.productsAdded(notification:)),
                                               name: NSNotification.Name(rawValue: NotificationID.productsAdded),
                                               object: nil)
        
        HackerNewsService.sharedInstance.getTheHackerNews(0, query)

        let hackerCell = UINib.init(nibName: "HackerViewCell", bundle: nil)
        self.tableView.register(hackerCell, forCellReuseIdentifier: "hackerID")
        tableView.refreshControl?.addTarget(self, action: #selector(HackerNewsTableViewController.handleRefresh), for: UIControlEvents.allEvents)
        setupSearchBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @objc func productsAdded(notification: NSNotification){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        var newsDict = notification.userInfo as! Dictionary<String, [Properties]>
        newsObject = newsDict["data"]!
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = newsObject[indexPath.row]
        performSegue(withIdentifier: "webSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webSegue" {
            let detailView = segue.destination as? WebViewController
            detailView?.selectedDetailObject = selectedItem
        }
    }
    
    @objc func handleRefresh() {
        self.tableView.refreshControl?.beginRefreshing()
//        tableView.scrollRectToVisible(CGRect.init(x:0, y:0, width:1, height:1), animated: true)

        HackerNewsService.sharedInstance.getTheHackerNews(cnt, query)
    }
    
}
