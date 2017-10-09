import UIKit

enum buttonTags: Int{
    case lightSwitch = 0
    case smallButton = 1
}
enum lightBulb {
    case on
    case off
}

class LightBulbViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lightBulbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleSwitch: UIButton!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    var bulb: lightBulb = lightBulb.on
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "First View"
        lightBulbImageView.image = UIImage.init(named: "lightOff")
        print("viewDidLoad")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lightBulbImageView.image = UIImage.init(named: "lightOn")
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lightBulbImageView.image = UIImage.init(named: "lightOff")
        print("viewDidDisappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchLight(_ sender: Any) {
        
        
        if let button = sender as? UIButton {
            switch button.tag{
            case buttonTags.lightSwitch.rawValue:
                changeImage()
                break
            case buttonTags.smallButton.rawValue:
                break
            default:
                break
            }
        }
    }
    func changeImage(){
        
        if lightBulbImageView.image == #imageLiteral(resourceName: "lightOff"){
            lightBulbImageView.image = #imageLiteral(resourceName: "lightOn")
            titleLabel.text = "On"
        } else{
            lightBulbImageView.image = #imageLiteral(resourceName: "lightOff")
            titleLabel.text = "Off"
        }
    }
    
    //        func lightSwitcher(){
    //            switch self{
    //            case .on :
    //                lightBulbImageView.image = #imageLiteral(resourceName: "lightOff")
    //                self = .off
    //            case .off:
    //                lightBulbImageView.image = #imageLiteral(resourceName: "lightOn")
    //                self = .on
    //            }
    //        }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        self.titleLabel.text = textField.text
        print("textFieldDidEndEditing")
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldShouldEndEditing")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            secondTextField.becomeFirstResponder()
        case 1:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

