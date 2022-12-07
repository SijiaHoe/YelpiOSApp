//
//  DetailView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI
import SwiftyJSON
import CoreLocation
import MapKit

struct DetailView: View {
    @Binding var id: String
    @ObservedObject var detailVM = DetailViewModel()
    @State private var showSheet: Bool = false
    @State private var isReserved: Bool = false
    @State private var isCancelled: Bool = false
    @Binding var hasDetail: Bool
    
    // mapView data
    @Binding var region: MKCoordinateRegion
    @Binding var places: [PointOfInterest]
    
    @AppStorage("res") var reservationList: Data?
    
    func getDetail() {
        let url = URL(string: ("https://csci571hw8-367920.uw.r.appspot.com/detail?id=\(id)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data {
                do {
                    let dataString = try JSON(data: data)
                    
                    detailVM.bName = dataString["name"].stringValue
                    
                    let addressArr = dataString["location"]["display_address"]
                    for i in addressArr {
                        detailVM.address.append(i.1.stringValue)
                        detailVM.address.append(" ")
                    }
                    detailVM.address = detailVM.address.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    let categories = dataString["categories"]
                    for i in categories {
                        detailVM.category.append(i.1["title"].stringValue)
                        detailVM.category.append(" | ")
                    }
                    detailVM.category = String(detailVM.category.dropLast(3))
                    
                    if dataString["display_phone"].stringValue.count != 0{
                        detailVM.phone = dataString["display_phone"].stringValue
                    }
                    else {
                        detailVM.phone = "N/A"
                    }
                    
                    detailVM.price = dataString["price"].stringValue
                    
                    let status = dataString["hours"][0]["is_open_now"].stringValue
                    if status == "true"{
                        detailVM.status = "Open Now"
                    }
                    else {
                        detailVM.status = "Closed"
                    }
                    
                    detailVM.link = dataString["url"].stringValue
                    
                    let pic = dataString["photos"]
                    for i in pic {
                        detailVM.photos.append(i.1.stringValue)
                    }
                    
                    let lat = Double(dataString["coordinates"]["latitude"].stringValue)!
                    let lng = Double(dataString["coordinates"]["longitude"].stringValue)!
                    self.region.center.latitude = lat
                    self.region.center.longitude = lng
                    
                    self.places = []
                    self.places.append(
                        PointOfInterest(name: self.detailVM.bName, latitude: lat, longitude:  lng)
                    )
                    
                    // if reserved or not
                    var data = try JSONDecoder().decode(Dictionary<String, Reservation>.self, from: reservationList!)
                    if data[self.id] != nil {
                        self.isReserved = true
                    }
                    else {
                        self.isReserved = false
                    }
                    
                    self.hasDetail = true
                }
                catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
    
    var body: some View {
        VStack(spacing: 50) {
            if !hasDetail{
                Text("")
                    .onAppear{
                        hasDetail = false
                        getDetail()
                    }
            }
            else {
                VStack{
                    Text(detailVM.bName)
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("**Address**")
                            Text(detailVM.address)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("**Category**")
                            Text(detailVM.category)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding([ .trailing, .leading, .bottom])
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("**Phone**")
                            Text(detailVM.phone)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("**Price Range**")
                            Text(detailVM.price)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding([ .trailing, .leading, .bottom])
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("**Status**")
                            if detailVM.status == "Open Now" {
                                Text("Open Now")
                                    .foregroundColor(.green)
                            }
                            else {
                                Text("Closed")
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("**Visit Yelp for more**")
                            Link("Business Link", destination: URL(string: detailVM.link)!)
                        }
                    }
                    .padding([ .trailing, .leading, .bottom])
                    
                    HStack {
                        // Reserve button
                        if !self.isReserved{
                            Button(action:{
                                showSheet.toggle()
                            }){
                                Text("Reserve Now")
                                    .frame(width: 100 , height: 20, alignment: .center)
                            }
                            .sheet(isPresented: $showSheet){
                                ReservationsView(id: self.$id, name: self.$detailVM.bName, isReserved: self.$isReserved)
                            }
                            .foregroundColor(Color.white)
                            .buttonStyle(.bordered)
                            .background(Color.red)
                            .controlSize(.large)
                            .cornerRadius(15)
                        }
                        // Cancel button
                        else {
                            Button(action: {
                                do {
                                    // delete from Local Storage
                                    var data = try JSONDecoder().decode(Dictionary<String, Reservation>.self, from: reservationList!)
                                    data.removeValue(forKey: self.id)
                                    reservationList = try? JSONEncoder().encode(data)
                                    self.isCancelled = true
                                    self.isReserved = false
                                }
                                catch {
                                    print("error")
                                }
                            }){
                                Text("Cancel Reservation")
                                    .frame(width: 148 , height: 20, alignment: .center)
                            }
                            .foregroundColor(Color.white)
                            .buttonStyle(.bordered)
                            .background(Color.blue)
                            .controlSize(.large)
                            .cornerRadius(15)
                        }
                    }
                    .padding(.bottom)
                    
                    // Social Media
                    HStack {
                        Text("**Share on:**")
                        
                        // Facebook
                        Link(destination: URL(string: ("https://www.facebook.com/sharer/sharer.php?u=\(detailVM.link)&quote=Check\(detailVM.bName)%20on%20Facebook.").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!) {
                            Image("facebook")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                .resizable()
                                .frame(width: 50.0, height: 50.0)
                        }
                        
                        // Twitter
                        Link(destination: URL(string: ("https://twitter.com/intent/tweet?text=Check \(detailVM.bName) on Yelp.&url=\(detailVM.link)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!) {
                            Image("twitter")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                .resizable()
                                .frame(width: 50.0, height: 50.0)
                        }
                    }
                    
                    // Images
                    HStack{
                        TabView {
                            ForEach(detailVM.photos, id: \.self) { photo in
                                AsyncImage(url: URL(string: photo)){ image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        .padding([ .trailing, .leading])
                    }
                }
                .toast(isPresented: self.$isCancelled) {
                    Text("Your reservation is cancelled.")
                }
            }
        }
    }
}
