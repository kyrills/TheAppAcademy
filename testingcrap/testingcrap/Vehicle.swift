import Foundation

enum typeCar{
    case car
    case tractor
    case lorry
}
class Vehicle{
    var speed: Double
    var weight: Double
    var colour: String
    var type: typeCar
    var lights: Bool?
    var currentSpeed: Double = 0
    
    init(speed: Double, weight: Double, colour: String, type: typeCar) {
        self.speed = speed
        self.weight = weight
        self.type = type
        self.colour = colour
    }
    
    func switchLights(on: Bool) {
        lights = on
    }
    
    func accelerating(x: Double) -> Double{
        while currentSpeed < speed {
            currentSpeed += x
            sleep(1)
            print(currentSpeed)
        }
        return currentSpeed
    }
}


    

