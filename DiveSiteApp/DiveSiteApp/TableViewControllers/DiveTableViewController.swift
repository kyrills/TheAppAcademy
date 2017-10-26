//
//  DiveTableViewController.swift
//  DiveSiteApp
//
//  Created by Kyrill van Seventer on 24/10/2017.
//  Copyright © 2017 Kyrill van Seventer. All rights reserved.
//

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
        
        
        let divingCell = UINib.init(nibName: "ShoppingCell", bundle: nil)
        self.tableView.register(divingCell, forCellReuseIdentifier: tableCellID.divingCellID)
        
        DiveSiteService.reference.getDiveSiteData()
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
        return diveItemObject.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempDiveObject = diveItemObject[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellID.divingCellID, for: indexPath) as! ShoppingCell

        // Configure the cell...
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTableViewItem = diveItemObject[indexPath.row]
        performSegue(withIdentifier: segues.detailTableViewSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  segues.detailTableViewSegue{
            let detailView = segue.destination as? DiveDetailTableViewController
            detailView?.selectedDetailObject = selectedTableViewItem
        }
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
