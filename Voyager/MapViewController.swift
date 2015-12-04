//
//  MapViewController.swift
//  Voyager
//
//  Created by Michael Duratinsky on 11/6/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBook
import MapKit
import Parse

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var status = CLLocationManager.authorizationStatus()
    let locationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    //var longitud = 89.4172
    //var latitude = 43.0750
    var location = CLLocationCoordinate2D()
    var annotation = MKPointAnnotation()
    var placeMark: CLPlacemark!
    var name, street, city, zipcode, country: String!
    
    func longPressAction(myLongPress: UILongPressGestureRecognizer) {
        
        //See where user clicks
        let myClick = myLongPress.locationInView(mapView)
        let myPointOnMap = mapView.convertPoint(myClick, toCoordinateFromView: mapView)
        
        //create annotation
        let tourAnnotation = MKPointAnnotation()
        tourAnnotation.coordinate = myPointOnMap
        tourAnnotation.title = "Tour"
        
        mapView.addAnnotation(tourAnnotation)
        
        let geoCoder = CLGeocoder()
        let newLocation = CLLocation(latitude: tourAnnotation.coordinate.latitude, longitude: tourAnnotation.coordinate.longitude)
        
        //Responsible for obtaining the address of the pin
        geoCoder.reverseGeocodeLocation(newLocation, completionHandler: { (placemarks, error) -> Void in let placeArray = placemarks 
            
            //var placeMark: CLPlacemark!
            self.placeMark = placeArray?[0]
            
            print(self.placeMark.addressDictionary)
        })
        
        
    }
    
    func longPressGesture() {
        let lpg = UILongPressGestureRecognizer(target: self, action: "longPressAction:")
        lpg.minimumPressDuration = 2
        
        mapView.addGestureRecognizer(lpg)
        
        
    }
    
    func centerMapOnLocation(longitude: Double, latitude: Double) {
        let latitude:CLLocationDegrees = latitude
        
        let longitude:CLLocationDegrees = longitude
        
        let latDelta:CLLocationDegrees = 0.02
        
        let lonDelta:CLLocationDegrees = 0.02
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)
    }
    
    func getUsersCurrentLocation() -> CLLocation {
        //Make sure the user allows us to use their location
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        var currentLocation = CLLocation!()
        
        //Check to make sure we allow location
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized){
                
                currentLocation = locManager.location
                
        }
        
        return currentLocation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        longPressGesture()
        
        mapView.showsUserLocation = true
        
        // Do any additional setup after loading the view, typically from a nib.
        /*
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        */
        
        //Obtains current location
        //let locationManager = CLLocationManager()
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //locationManager.delegate = self;
        //locationManager.requestAlwaysAuthorization()
        //locationManager.startUpdatingLocation()
        //locationManager.startUpdatingHeading()
        
        //CLLocationManager locationManager = new CLLocationManager();
        locationManager.requestWhenInUseAuthorization();
        mapView.showsUserLocation = true;
        
        //Zooms into current location
//        location = CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.longitude, longitude: mapView.userLocation.coordinate.latitude)
        
        let currentLocation =  getUsersCurrentLocation()
        
        let longitude = currentLocation.coordinate.longitude
        let latitude = currentLocation.coordinate.latitude
        
        myPosition.longitude = longitude
        myPosition.latitude = latitude
        
        centerMapOnLocation(longitude, latitude: latitude)
        
        //User can add pins with longPress
        
        //location = CLLocationCoordinate2D(latitude: 51.5072, longitude: 0.1275)
        //let span = MKCoordinateSpanMake(1.0, 1.0)
        //let region = MKCoordinateRegion(center: location, span: span)
        //mapView.setRegion(region, animated: true)
        
        //Sets up
        //annotation.coordinate = location
        //annotation.title = "Roatan"
        //annotation.subtitle = "Honduras"

        /*
        print("**********")
        print(mapView.userLocation.coordinate)
        let mapCenter = mapView.userLocation.coordinate
        let mapCamera = MKMapCamera(lookingAtCenterCoordinate: mapCenter, fromEyeCoordinate: mapCenter, eyeAltitude: 5000)
        mapView.setCamera(mapCamera, animated: true)
        */
        // Do any additional setup after loading the view.
    }
    
    //func longPressAction() {
    //    print(" did long press")
    //}
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        print("present location : \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")
        
        //myPosition = newLocation.coordinate
        
        //let span = MKCoordinateSpanMake(3.0, 3.0)
        //let region = MKCoordinateRegionMake(newLocation.coordinate, span)
        //mapView.setRegion(region, animated: true)
        //longitud = newLocation.coordinate.longitude
        //latitude = newLocation.coordinate.latitude

        
    }

    @IBAction func addPin(sender: UILongPressGestureRecognizer) {
        let location = sender.locationInView(self.mapView)
        
        let locCoord = self.mapView.convertPoint(location, toCoordinateFromView: self.mapView)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = locCoord
        annotation.title = "Event"
    }
    
    
    /*
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) -> Void in
            
            if error != nil {
                print("error")
                return
            }
            
            if(placemarks!.count > 0) {
                let pm = placemarks![0] as CLPlacemark
                self.displayLocationInfo(pm)
            }
        }
    }
    */
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        //Dismiss view controller
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

