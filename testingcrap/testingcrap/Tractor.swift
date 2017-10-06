import Foundation

class Tractor: Vehicle {
    var loadingCapacity: Double
    
//    init(loadingCapacity: Double) {
//        self.loadingCapacity = loadingCapacity
//    }
    func loadTractor() -> Bool {
        if type = .tractor{
            var cargo: Double = 0
            while cargo != loadingCapacity {
            cargo += 1
        }
        print(cargo)
    }
}
