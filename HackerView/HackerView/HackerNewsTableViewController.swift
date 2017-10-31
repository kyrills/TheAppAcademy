import UIKit

class HackerNewsTableViewController: UITableViewController {

    var newsObject: [Properties] = []
    var selectedItem: Properties?
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
        self.refreshControl?.addTarget(self, action: #selector(HackerNewsTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsObject.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.newsCellID, for: indexPath) as! HackerViewCell
        
        if indexPath.row % 2 == 0 {
            cell.articleTitle.backgroundColor = UIColor.lightGray
            cell.articleAuthor.backgroundColor = UIColor.lightGray
            cell.contentView.backgroundColor = UIColor.lightGray
            cell.articleAuthor.textColor = UIColor.white
        } else{
            cell.contentView.backgroundColor = UIColor.white
            cell.articleTitle.backgroundColor = UIColor.white
            cell.articleAuthor.backgroundColor = UIColor.white
            cell.articleAuthor.textColor = UIColor.lightGray
            
        }
        
        
        let tempNews = newsObject[indexPath.row]
        cell.articleTitle.text = tempNews.storyTitle
        let time =  tempNews.createdAt.timePassed()
        cell.articleAuthor.text = "\(tempNews.author) - \(time)"

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.newsObject.count - 1 {
            cnt += 1
            HackerNewsService.sharedInstance.getTheHackerNews(cnt, query)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            newsObject.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    @objc func productsAdded(notification: NSNotification){
        var newsDict = notification.userInfo as! Dictionary<String, [Properties]>
        newsObject = newsDict["data"]!
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = newsObject[indexPath.row]
        performSegue(withIdentifier: "webSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webSegue" {
            let detailView = segue.destination as? WebViewController
            detailView?.selectedDetailObject = selectedItem
        }
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        
        HackerNewsService.sharedInstance.getTheHackerNews(cnt, query)
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
}
