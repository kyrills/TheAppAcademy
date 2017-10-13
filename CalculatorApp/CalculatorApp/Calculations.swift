import Foundation

class Calculations{
    
    var accumulator: Double = 0
    var history: String = ""
    var lastOperation = ""  //+ or  - or /
    var total: Double = 0
    
    func add(_ first: Double) -> Double {
        total = total + first
        accumulator = first + accumulator
        return accumulator
    }
    func substract(_ first: Double) -> Double {
        accumulator = accumulator - first
        return accumulator
    }
    func divide(_ first: Double) -> Double {
        accumulator = first / accumulator
        return accumulator
    }
    func multiply(_ first: Double) -> Double{
        accumulator =  first * accumulator
        return accumulator
    }
    
    func doOperation(operatorType: String) -> String{
        var result = ""
        switch operatorType {
        case "+":
            if let numberHis = Double(history) {
                let num = add(numberHis)
                result = String(num)
                lastOperation = "+"
                history = ""
                //                calculator.accumulator = 0
            }
            break
        case "-":
            if let numberHis = Double(history){
                let num = substract(numberHis)
                ViewController().calculatorDisplay.text = String(num)
                history = ""
            }
            break
        case "*":
            if let numberHis = Double(history){
                let num = multiply(numberHis)
                ViewController().calculatorDisplay.text = String(num)
                history = ""
            }
            break
        case "/":
            if let numberHis = Double(history){
                let num = divide(numberHis)
                ViewController().calculatorDisplay.text = String(num)
                history = ""
            }
            break
        case "AC":
            history = ""
            total = 0
            accumulator = 0
            ViewController().calculatorDisplay.text = ""
            break
        case "=":
            ViewController().calculatorDisplay.text = String(total)
            total = 0
            accumulator = 0
            break
        default:
            //            calculatorDisplay.text = String(calculator.total)
            //            calculator.total = 0
            //            calculator.accumulator = 0
            break
        }
        return result
    }
    //    func uitkomst(_ totale: Double) -> Double{
    
    //        return totale
    //    }
}
