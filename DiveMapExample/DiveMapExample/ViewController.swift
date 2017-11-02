import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate {
    
    var lastCoordinateTouched = CLLocationCoordinate2D()
    var diveSites: [DiveMapDataProperties] = []
    var locationmanager = CLLocationManager()
    let droppedPin = MKPointAnnotation()
    var selectedDiveSite: DiveDetailProperties?
    var selectedDetail: String?


    @IBOutlet weak var diveMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationmanager.delegate = self
        self.locationmanager.requestWhenInUseAuthorization()

        diveMapView.showsUserLocation = true
        diveMapView.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.initialDataRetrieve(notification:)),
                                               name: NSNotification.Name(rawValue: NotificationID.initialDataRetreive),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.detailViewData(notification:)),
                                               name: NSNotification.Name(rawValue: NotificationID.detailViewData),
                                               object: nil)
    }
    func setZoomInitialLocation(location: CLLocationCoordinate2D){
        let regionRadius: CLLocationDistance = 12000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0,
                                                                  regionRadius * 2.0)
        diveMapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        if let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin"){
            return pinView
        } else {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pinView.pinTintColor = UIColor.magenta
            pinView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            pinView.canShowCallout = true
            pinView.animatesDrop = true
            return pinView
        }
    }

    @objc func initialDataRetrieve(notification: NSNotification){
        var diveDict = notification.userInfo as! Dictionary<String, [DiveMapDataProperties]>
        diveSites = diveDict["data"]!
        var annotations: [DiveMapAnnotation] = []
        
        for site in diveSites{
            
            let coordinate = CLLocationCoordinate2D.init(latitude: site.latitude, longitude: site.longitude)
            let annotation = DiveMapAnnotation.init(diveSite: site, coordinate: coordinate)

            annotation.title = site.name
            annotations.append(annotation)
        }
        self.diveMapView.showAnnotations(annotations, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let detailStuff = view.annotation as? DiveMapAnnotation{
            DiveMapService.sharedInstance.getDiveDetail(id: detailStuff.diveSite.id)
        }
    }
    
    @objc func detailViewData(notification: NSNotification){
        
        var diveLocationDetail = notification.userInfo as! Dictionary< String, DiveDetailProperties>
        selectedDiveSite = diveLocationDetail["data"]!

        
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let detailView = segue.destination as? DetailViewController
            detailView?.selectedDetailViewObject = self.selectedDiveSite
        }
    }
    
    @IBAction func revealRegionDetailsWithLongPressOnMap(sender: UILongPressGestureRecognizer) {
        guard sender.state == .began else { return }
    
        let touchLocation = sender.location(in: diveMapView)
        let locationCoordinate = diveMapView.convert(touchLocation, toCoordinateFrom: self.diveMapView)
        
        
        self.diveMapView.removeAnnotation(self.droppedPin)
        droppedPin.title = "Dropped Pin"
        droppedPin.coordinate = locationCoordinate
        
        let droppedPinView = MKPinAnnotationView.init(annotation: droppedPin, reuseIdentifier: "pin")
        droppedPinView.pinTintColor = UIColor.blue
    
        
        self.diveMapView.addAnnotation(droppedPinView.annotation!)
        
        DiveMapService.sharedInstance.getDiveMapData(lat: locationCoordinate.latitude, lng: locationCoordinate.longitude, dist: 25)
        
        setZoomInitialLocation(location: locationCoordinate)
    }
    
}

