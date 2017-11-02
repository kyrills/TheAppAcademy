import Foundation
import MapKit

class DiveMapAnnotation: NSObject, MKAnnotation{
    var diveSite: DiveMapDataProperties
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(diveSite: DiveMapDataProperties, coordinate: CLLocationCoordinate2D) {
        self.diveSite = diveSite
        self.coordinate = coordinate
    }
}

