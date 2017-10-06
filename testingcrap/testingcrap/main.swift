import Foundation

var mercedes = Car.init(speed: 300.0, weight: 933.0, colour: "Blue" , type: .car)
var audi = Car.init(speed: 250.0, weight: 1500.9, colour: "Black", type: .car)
var scania = Lorry.init(speed: 50, weight: 4000, colour: "Green", type: .lorry)

//audi.switchLights(on: true)

//audi.accelerating(x: 10)

scania.loadCargoLorry(cargo: "Red Bull")
