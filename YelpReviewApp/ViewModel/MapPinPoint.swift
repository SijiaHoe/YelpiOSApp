//
//  MapPinPoint.swift
//  YelpReviewApp
//
//  Created by LilHoe on 12/3/22.
//

import Foundation
import MapKit

struct PointOfInterest: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
