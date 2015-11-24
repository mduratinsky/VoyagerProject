//
//  DirectionsViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 11/22/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit
import MapKit

class DirectionsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    var pinLocation = CLLocationCoordinate2D()
    var destination = MKMapItem()
    var locationTitle: String = ""
    var locationDescription: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        
        let currentLocation =  getUsersCurrentLocation()
        
        let longitude = currentLocation.coordinate.longitude
        let latitude = currentLocation.coordinate.latitude
        
        myPosition.longitude = longitude
        myPosition.latitude = latitude
        
        centerMapOnLocation(longitude, latitude: latitude)
        
        pinLocation.longitude = -89.3956120
        pinLocation.latitude = 43.0718120
        addPin(pinLocation)
        
        drawDirections()
        
    }
    
    //MARK: - MapView
    
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
    
    func addPin(pinLocation: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = pinLocation
        annotation.title = locationTitle
        
        let placeMark = MKPlacemark(coordinate: pinLocation, addressDictionary: nil)
        destination =  MKMapItem(placemark: placeMark)
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotation(annotation)
    }
    
    func drawDirections() {
        let request = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        
        request.destination = destination
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler({(response:
            MKDirectionsResponse?, error: NSError?) in
            
            if error != nil {
                print("Error \(error)")
            } else {
                
                let overlays = self.mapView.overlays
                self.mapView.removeOverlays(overlays)
                
                for route in response!.routes {
                    self.mapView.addOverlay(route.polyline,
                        level: MKOverlayLevel.AboveRoads)
                    
                    for next in route.steps {
                        print(next.instructions)
                    }
                }
            }
        })
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let draw = MKPolylineRenderer(overlay: overlay)
        draw.strokeColor = UIColor.MKColor.Blue
        draw.lineWidth = 3.0
        return draw
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
