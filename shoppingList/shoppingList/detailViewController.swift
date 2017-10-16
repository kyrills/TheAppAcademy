//
//  detailViewController.swift
//  shoppingList
//
//  Created by Kyrill van Seventer on 16/10/2017.
//  Copyright © 2017 Kyrill van Seventer. All rights reserved.
//

import UIKit

class detailViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var detailViewLabel: UILabel!
    var shopItem: String = " "
    var imageStore: String = " "
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewLabel.text = shopItem

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
