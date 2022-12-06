//
//  DetailTabView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 12/3/22.
//

import SwiftUI
import CoreLocation
import MapKit

struct DetailTabView: View {
    @State var id: String
    @State var hasDetail: Bool = false
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 40.83834587046632,
            longitude: 14.254053016537693),
        span: MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1)
    )
    @State var places: [PointOfInterest] = []
    
    var body: some View {
        TabView {
            DetailView(id: self.$id, hasDetail: self.$hasDetail, region: self.$region, places: self.$places)
                .tabItem {
                    Label("Business Detail", systemImage: "text.bubble.fill")
                }
            MapView(hasResult: self.$hasDetail, region: self.$region, places: self.$places)
                .tabItem {
                    Label("Map Location", systemImage: "location.fill")
                }
            CommentView(id: self.$id)
                .tabItem {
                    Label("Reviews", systemImage: "message.fill")
                }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}
