import Foundation

class Calculation{
    func bmi(_ weight: Int, _ height: Double) -> String {
        let bmiValue = Double(weight)/(height*height)
        var returnString: String
        
        switch bmiValue {
        case _ where bmiValue <= 18.5:
            returnString = "Underweight"
        case _ where bmiValue <= 25.0:
            returnString = "Normal"
        case _ where bmiValue <= 30.0:
            returnString = "Overweight"
        default:
            returnString = "Obese"
        }
        return returnString
    }

}
