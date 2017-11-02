import UIKit
import Foundation

extension HackerNewsTableViewController: UISearchBarDelegate{
    
    func setupSearchBar(){
        self.searchController = UISearchController.init(searchResultsController: nil)
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = false
        
        navigationItem.titleView = searchController?.searchBar
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.count)! >= 3 {
            activityWheel()
            query = searchBar.text!.removeSpecialCharsFromString()
            HackerNewsService.sharedInstance.emptyStuff(cnt, query)
        }
    }
    
    func activityWheel(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}
