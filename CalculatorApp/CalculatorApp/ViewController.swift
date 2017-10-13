import UIKit

class ViewController: UIViewController {

//    var numberOnScreen:Double = 0;
//    var previousNumber:Double = 0;
//    var performingMath = false
    var operation = 0;
    var usedOperator = ""
    var calculator:  Calculations = Calculations()
    @IBOutlet weak var calculatorDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func numberTapped(sender: UIButton) {
        
        calculator.history.append((sender.titleLabel?.text)!)
        calculatorDisplay.text = calculator.history
        print(calculator.history)
        print(calculator.total)
        
        
//        let input = sender.currentTitle
//        calculatorDisplay.text = sender.currentTitle
//        if performingMath == true
//        {
//
//            numberOnScreen = Double(calculatorDisplay.text!)!
//            performingMath = false
//
//            switch usedOperator {
//            case _ where usedOperator == "+":
//                calculatorDisplay.text = String(Calculations().add(previousNumber, numberOnScreen))
//            default:
//                print("hey")
//            }
//
//        }
//        else
//        {
//            calculatorDisplay.text = calculatorDisplay.text! + String(sender.tag)
//            numberOnScreen = Double(calculatorDisplay.text!)!
//        }
        
//        print(sender.currentTitle)
    }
  

    @IBAction func operatorTapped(sender: UIButton) {
        if let operatorType = sender.titleLabel?.text {
            calculator.doOperation(operatorType: operatorType)
        }
        
//        
//        let shitdoesntwork = sender.titleLabel?.text
//        switch sender {
//        case _ where shitdoesntwork == 21:
//            previousNumber = numberOnScreen
//            usedOperator = "+"
//            performingMath = true
//        case _ where shitdoesntwork == 22:
//            previousNumber = numberOnScreen
//        default:
//            print("hey")
//        }
            

        
    }
    
//    @IBAction func calculationTapped(sender: AnyObject) {
//        isTypingNumber = false
//        firstNumber = calculatorDisplay.text.toInt()!
//        operation = sender.currentTitle
    
}

