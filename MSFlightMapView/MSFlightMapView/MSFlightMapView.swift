//
//  MSFlightMapView.swift
//  MSFlightMapView
//
//  Created by Muhammad Abdul Subhan on 19/01/2018.
//  Copyright © 2018 Subhan. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

open class MSFlightMapView: UIView {
    
    var mapView: GMSMapView?
    var flightViews: [MSFlightView] = [MSFlightView]()
    
    public init(withFrame frame:CGRect, andFlights flights:[MSFlight]) {
        super.init(frame: frame)
        
        // Setting MapView
        let camera = GMSCameraPosition.camera(withLatitude: (flights.first?.departure.latitude)!, longitude: (flights.first?.departure.longitude)!, zoom: 5.0)
        mapView = GMSMapView.map(withFrame: self.frame, camera: camera)
        
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                self.mapView?.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        self.addSubview(mapView!)
        
        for flight in flights {
            flightViews.append(MSFlightView.init(withMapView: mapView!, andFlight: flight))
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
