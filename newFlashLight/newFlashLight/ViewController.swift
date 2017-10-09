//
//  ViewController.swift
//  newFlashLight
//
//  Created by Kyrill van Seventer on 08/10/2017.
//  Copyright © 2017 Kyrill van Seventer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageSomething: UIImageView!
    @IBOutlet weak var lightOff: UIImageView!
    var checker: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func lightSwitch(_ sender: Any) {
        
        if checker == 0{
            lightOff.image = UIImage(named: "lightOn")
            checker = 1
        } else{
            lightOff.image = UIImage(named: "lightOff")
            checker = 0
        }
    }
    
}

