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

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    var status = CLLocationManager.authorizationStatus()
    let locationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        // Do any additional setup after loading the view, typically from a nib.
        /*
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        */
        
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        /*
        print("**********")
        print(mapView.userLocation.coordinate)
        let mapCenter = mapView.userLocation.coordinate
        let mapCamera = MKMapCamera(lookingAtCenterCoordinate: mapCenter, fromEyeCoordinate: mapCenter, eyeAltitude: 5000)
        mapView.setCamera(mapCamera, animated: true)
        */
        // Do any additional setup after loading the view.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        print("present location : \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")
        
        myPosition = newLocation.coordinate
        
        let span = MKCoordinateSpanMake(3.0, 3.0)
        let region = MKCoordinateRegionMake(newLocation.coordinate, span)
        mapView.setRegion(region, animated: true)
        
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

