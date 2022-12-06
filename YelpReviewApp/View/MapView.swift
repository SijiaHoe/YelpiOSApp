//
//  MapView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var hasResult: Bool
    @Binding var region: MKCoordinateRegion
    @Binding var places: [PointOfInterest]
    
    var body: some View {
        if !hasResult {
            Text("")
        }
        else {
            Map(coordinateRegion: $region, annotationItems: places) { place in
                MapMarker(coordinate: place.coordinate)
            }
        }
    }
}

