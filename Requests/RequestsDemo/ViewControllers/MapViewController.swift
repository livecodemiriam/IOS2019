//
//  MapViewController.swift
//  RequestsDemo
//
//  Created by Cristian Olteanu on 13/03/2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var lat: Double!
    var lng: Double!
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let latDelta:CLLocationDegrees = 0.01
        
        let longDelta:CLLocationDegrees = 0.01
        
        let theSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let pointLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lng)
        
        let region:MKCoordinateRegion = MKCoordinateRegion(center: pointLocation, span: theSpan)
        mapView.setRegion(region, animated: true)
        
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lng)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        self.mapView.addAnnotation(objectAnnotation)
    }
    @IBAction func pressedClose() {
        dismiss(animated: true, completion: nil)
    }
}
