//
//  MapView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 40.83834587046632,
            longitude: 14.254053016537693),
        span: MKCoordinateSpan(
            latitudeDelta: 0.03,
            longitudeDelta: 0.03)
    )
    
    private let places = [
        PointOfInterest(name: "Galeria Umberto I", latitude: 40.83859036140747, longitude:  14.24945566830365)
    ]
    
    var body: some View {
        VStack{
            Map(coordinateRegion: $region, annotationItems: places) { place in
                MapMarker(coordinate: place.coordinate)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
