import UIKit

class detailViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var detailViewLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var imageStore: String = " "
    var selectedDetailObject: ShoppingItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewLabel.text = selectedDetailObject?.productName
//        var prices: = selectedDetailObject?.productPrice
        
        let a:Double = (selectedDetailObject?.productPrice)!
        let b:String = String(format:"%.2f", a)

        priceLabel.text = b
        
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
