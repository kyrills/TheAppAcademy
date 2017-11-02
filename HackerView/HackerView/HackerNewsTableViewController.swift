//
//  TableViewStuff.swift
//  HackerView
//
//  Created by Kyrill van Seventer on 31/10/2017.
//  Copyright © 2017 Kyrill van Seventer. All rights reserved.
//

import Foundation
import UIKit

extension HackerNewsTableViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsObject.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.newsObject.count - 1 {
            cnt += 1
            HackerNewsService.sharedInstance.getTheHackerNews(cnt, query)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            newsObject.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
