//
//  DetailModel.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import Foundation
import SwiftyJSON
import CoreLocation

class DetailViewModel: ObservableObject {
    @Published var bName: String = ""
    @Published var address: String = ""
    @Published var category: String = ""
    @Published var phone: String = ""
    @Published var price: String = ""
    @Published var status: String = ""
    @Published var link: String = ""
    @Published var photos: [String] = []
    @Published var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var id: String = ""
    
    // TODO: get map pin location
    
    func getDetail() {
        id = "vWpuRdatiCaxbdqhbqX0rw"
        let url = URL(string: "https://csci571hw8-367920.uw.r.appspot.com/detail?id=\(id)")!
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
                    
                    self.bName = dataString["name"].stringValue
                    
                    let addressArr = dataString["location"]["display_address"]
                    for i in addressArr {
                        self.address.append(i.1.stringValue)
                        self.address.append(" ")
                    }
                    self.address = self.address.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    let categories = dataString["categories"]
                    for i in categories {
                        self.category.append(i.1["title"].stringValue)
                        self.category.append(" | ")
                    }
                    self.category = String(self.category.dropLast(3))
                    
                    self.phone = dataString["display_phone"].stringValue
                    
                    self.price = dataString["price"].stringValue
                    
                    let status = dataString["hours"][0]["is_open_now"].stringValue
                    if status == "true"{
                        self.status = "Open Now"
                    }
                    else {
                        self.status = "Closed"
                    }
                    
                    self.link = dataString["url"].stringValue
                    
                    let pic = dataString["photos"]
                    for i in pic {
                        self.photos.append(i.1.stringValue)
                    }
                    
                    self.coordinate.latitude = Double(dataString["coordinates"]["latitude"].stringValue)!
                    self.coordinate.longitude = Double(dataString["coordinates"]["longitude"].stringValue)!
                    print(dataString)
                }
                catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
}
