//
//  SearchModel.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import Foundation
import SwiftyJSON

class SearchViewModel: ObservableObject {
    @Published var keyword: String = ""
    @Published var distance: String = "10"
    @Published var category: String = "Default"
    @Published var location: String = ""
    
    var latitude = ""
    var longitude = ""
    
    //    async throws -> [BusinessViewModel]
    func getCurrentLocation()  {
        let url = URL(string: "https://ipinfo.io/json?token=026d73b0fd6fa7")!
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
                    let array = dataString["loc"].stringValue.components(separatedBy: ",")
                    self.latitude = array[0]
                    self.longitude = array[1]
                    self.getYelpSearch()
                }
                catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
    
    // call Google Geolocation API to get lat and long
    func getGeoLocation() {
        let url = URL(string: "https://csci571hw8-367920.uw.r.appspot.com/address?address=\(self.location)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print(url)
        
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data {
                do {
                    let locationInfo = try JSON(data: data)
                    self.latitude = locationInfo["results"][0]["geometry"]["location"]["lat"].stringValue
                    self.longitude = locationInfo["results"][0]["geometry"]["location"]["lng"].stringValue
                    print(latitude)
                    self.getYelpSearch()
                }
                catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
    
    // call backend to get Yelp Search Result
    func getYelpSearch() {
        let radius = String(Int(self.distance)! * 1600)
        var categories: String {
            switch category{
                case "Default":
                    return "all"
                case "Arts and Entertainment":
                    return "arts"
                case "Health and Medical":
                    return "health"
                case "Hotels and Travel":
                    return "hotelstravel"
                case "Food":
                    return "food"
                case "Professional Services":
                    return "professional"
                default:
                    return "all"
            }
        }
        let url = URL(string: "https://csci571hw8-367920.uw.r.appspot.com/list?term=\(self.keyword)&radius=\(radius)&categories=\(categories)&latitude=\(self.latitude)&longitude=\(self.longitude)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        var results:[BusinessViewModel] = []
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data {
                do {
                    let searchResult = try JSON(data: data)
                    var len: Int = searchResult["businesses"].count  // max:20
                    len = len > 10 ? 10 : len
                    let res = searchResult["businesses"]
                    for i in 0...len-1 {
                        let b = BusinessViewModel()
                        b.bName = res[i]["name"].stringValue
                        b.rating = res[i]["rating"].stringValue
                        let distance: Float = Float(res[i]["distance"].stringValue)! / 1600
                        b.distance = String(Int(distance))
                        b.id = res[i]["id"].stringValue
                        let img: String = res[i]["image_url"].stringValue
                        // no image
                        if img.count == 0 {
                            b.photo = "https://media.istockphoto.com/vectors/no-image-available-sign-vector-id1138179183?k=20&m=1138179183&s=612x612&w=0&h=iJ9y-snV_RmXArY4bA-S4QSab0gxfAMXmXwn5Edko1M="
                        }
                        else {
                            b.photo = img
                        }
                        results.append(b)
                    }
                }
                catch {
                    print("error")
                }
            }
        }
        task.resume()
        return
    }
    
    // call backend to get Yelp API autocomplete result
    func autoComplete() -> [String] {
        // autocomplete results
        var autoItems: [String] = []
        
        let url = URL(string: "https://csci571hw8-367920.uw.r.appspot.com/autocomplete?text=\(self.keyword)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data {
                do {
                    let dataString = try JSON(data: data)
                    let terms = dataString["terms"]
                    let categories = dataString["categories"]
                    for term in terms {
                        autoItems.append(term.1["text"].stringValue)
                    }
                    for category in categories {
                        autoItems.append(category.1["title"].stringValue)
                    }
                }
                catch {
                    print("error")
                }
            }
        }
        task.resume()
        return autoItems
    }
}
