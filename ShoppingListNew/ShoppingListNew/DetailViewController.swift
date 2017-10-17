import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var productNameLabel: UITextField!
    @IBOutlet weak var productPriceLabel: UITextField!
    @IBOutlet weak var productImageView: UIImageView!
    
    
    var selectedDetailObject: ShoppingItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productNameLabel.text = selectedDetailObject?.productName
        let a:Double = (selectedDetailObject?.productPrice)!
        let b:String = String(format:"%.2f", a)
        productPriceLabel.text = b

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else{
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        productImageView.image = image
        dismiss(animated: true, completion: nil)
        }
    

}
