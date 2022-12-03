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
    @Published var checked: Bool = false
    
    var latitude = ""
    var longitude = ""
    
    func submit() {
//        if self.checked {
//            self.getCurrentLocation()
//        }
//        else {
//            self.getGeoLocation()
//        }
        self.autoComplete()
    }
    
    func getCurrentLocation() {
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
        print(categories)
        print(self.latitude)
        let url = URL(string: "https://csci571hw8-367920.uw.r.appspot.com/list?term=\(self.keyword)&radius=\(radius)&categories=\(categories)&latitude=\(self.latitude)&longitude=\(self.longitude)")!
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
                    let searchResult = try JSON(data: data)
                    
                }
                catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
    
    func autoComplete(){
        let url = URL(string: "https://csci571hw8-367920.uw.r.appspot.com/autocomplete?text=\(self.keyword)")!
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
