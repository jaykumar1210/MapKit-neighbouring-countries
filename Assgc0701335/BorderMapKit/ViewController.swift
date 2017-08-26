//
//  ViewController.swift
//  695504_assignment
//
//  Created by Macstudent on 2017-03-30.
//  Copyright © 2017 Macstudent. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mapObj: MKMapView!
    @IBOutlet weak var countryone: UITextField!
    @IBOutlet weak var countrytwo: UITextField!
    
    
    var mapManager = CLLocationManager()
    
    var border : [Border] = []
    var annotations : [MKPointAnnotation] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryone.delegate = self
        countrytwo.delegate = self
        mapManager.desiredAccuracy = kCLLocationAccuracyBest
        mapManager.requestWhenInUseAuthorization()
        mapManager.startUpdatingLocation()
        mapObj.delegate = self
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func matchbrdr(_ sender: UIButton) {
           mapObj.removeAnnotations(annotations)
        countryone.resignFirstResponder()
        if let b1 = retrieveData(countryName: countryone.text!), let b2 = retrieveData(countryName: countrytwo.text!) {
            /* let userAnnotation = MKPointAnnotation()
             userAnnotation.coordinate = CLLocationCoordinate2DMake(b1.country.latitude, b1.country.longitude)
             
             mapObj.addAnnotation(userAnnotation)
             annotations.append(userAnnotation)*/
            
            
            // Here we define the map's zoom. The value 0.01 is a pattern
            let zoom:MKCoordinateSpan = MKCoordinateSpanMake(100, 100)
            
            // Store latitude and longitude received from smartphone
            let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(b1.country.latitude, b1.country.longitude)
            
            // Based on myLocation and zoom define the region to be shown on the screen
            let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, zoom)
            
            // Setting the map itself based previous set-up
            mapObj.setRegion(region, animated: true)
            
            
            for c in b1.countryborder {
                for d in b2.countryborder{
                    
                    if c.countryName == d.countryName{
                        let countryBorderAnnotation = MKPointAnnotation()
                        countryBorderAnnotation.coordinate = CLLocationCoordinate2DMake(c.latitude, c.longitude)
                        mapObj.addAnnotation(countryBorderAnnotation)
                        annotations.append(countryBorderAnnotation)
                    }
                }
            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
    
    // dismiss the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func loadData(){
        let ca = Country(name: "Canada", capital: "Otawa", latitude: 45.419124, longitude: -75.704084)
        let usa = Country(name: "USA", capital: "Washington", latitude: 38.897992, longitude: -77.035511)
        let mex = Country(name: "Mexico", capital: "Mexico DF", latitude: 19.431713, longitude: -99.129942)
        let prt = Country(name: "Portugal", capital: "Lisboa", latitude: 38.729101, longitude: -9.137683)
        let sp  = Country(name: "Spain", capital: "Madrid", latitude: 40.416545, longitude: -3.703608)
        let ind = Country(name: "India", capital: "New Delhi", latitude:20.5937, longitude: 78.9629)
        let china = Country(name: "China", capital:"Beijing", latitude:39.9042, longitude: 116.4074)
        let nep = Country(name: "Nepal", capital:"Kathmandu", latitude:27.7172, longitude: 85.3240)
        let bht = Country(name: "Bhutan", capital:"Thimphu", latitude:27.4728, longitude: 89.6393)
        
        let b1 = Border(country: ca)
        b1.addBorder(country: usa)
        
        let b2 = Border(country: usa)
        b2.addBorder(country: ca)
        b2.addBorder(country: mex)
        
        
        let b3 = Border(country: mex)
        b3.addBorder(country: usa)
        
        let b4 = Border(country: prt)
        b4.addBorder(country: sp)
        
        let b5 = Border(country: ind)
        b5.addBorder(country: nep)
        b5.addBorder(country: bht)
        
        let b6 = Border(country:china)
        b6.addBorder(country: nep)
        b6.addBorder(country: bht)
        
        border.append(b1)
        border.append(b2)
        border.append(b3)
        border.append(b4)
        border.append(b5)
        border.append(b6)
    }
    
    func retrieveData(countryName : String) -> Border? {
        for b in border {
            if b.country.countryName == countryName {
                return b
            }
        }
        return nil
    }
    
    
    
    
}


