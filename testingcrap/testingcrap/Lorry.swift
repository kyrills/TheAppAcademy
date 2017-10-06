import Foundation

class Lorry: Vehicle {
    var typeCargo = ""
    
    func loadCargoLorry(cargo: String)  {
        if type == .lorry {
            self.typeCargo = cargo
        }
    }
}
