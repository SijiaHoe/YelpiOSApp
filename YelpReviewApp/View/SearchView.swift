//
//  SearchView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI
import Foundation
import SwiftyJSON

struct SearchView: View {
    @State var keyword: String = ""
    @State var distance: String = "10"
    @State var category: String = "Default"
    @State var location: String = ""
    @State var showsAlwaysPopover: Bool = false
    @State var checked: Bool = false
    
    @State var latitude = ""
    @State var longitude = ""
    
    @Binding var results: [BusinessViewModel]
    @State var autoItems: [String] = []
    
    @State var hasAutoResult: Bool = false
    @Binding var hasYelpResult: Bool
    
    @Binding var submitted:Bool
    
    let categories = ["Default", "Arts and Entertainment", "Health and Medical", "Hotels and Travel", "Food", "Professional Services"]
    
    // Form validation
    var formIsValid: Bool {
        return !self.keyword.isEmpty && !self.distance.isEmpty && (!self.location.isEmpty || self.checked)
    }
    var buttonColor: Color {
        return formIsValid ? .red : .gray
    }
    
    // call IPInfo to get current location
    func getCurrentLocation() {
        let url = URL(string: ("https://ipinfo.io/json?token=026d73b0fd6fa7").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
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
        let url = URL(string: ("https://csci571hw8-367920.uw.r.appspot.com/address?address=\(self.location)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
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
                    let locationInfo = try JSON(data: data)
                    self.latitude = locationInfo["results"][0]["geometry"]["location"]["lat"].stringValue
                    self.longitude = locationInfo["results"][0]["geometry"]["location"]["lng"].stringValue
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
        self.results = []
        
        // addingPercentEncoding: convert whitespace to %20
        let url = URL(string: ("https://csci571hw8-367920.uw.r.appspot.com/list?term=\(self.keyword)&radius=\(radius)&categories=\(categories)&latitude=\(self.latitude)&longitude=\(self.longitude)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
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
                        self.results.append(b)
                    }
                    self.hasYelpResult = true
                }
                catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
    
    // call backend to get Yelp API autocomplete result
    func autoComplete() {
        let url = URL(string: ("https://csci571hw8-367920.uw.r.appspot.com/autocomplete?text=\(self.keyword)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        self.autoItems = []
        
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
                        self.autoItems.append(term.1["text"].stringValue)
                    }
                    for category in categories {
                        self.autoItems.append(category.1["title"].stringValue)
                    }
                    self.hasAutoResult = true
                }
                catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
    
    var body: some View {
        // search setion
        Section{
            HStack {
                Text("Keyword:")
                    .foregroundColor(.secondary)
                // add autocomplete popOver
                TextField("Required", text: self.$keyword)
                    .onChange(of: self.keyword, perform: { newValue in
                        if self.keyword.count == 0 {
                            showsAlwaysPopover = false
                        }
                        else {
                            self.hasAutoResult = false
                            showsAlwaysPopover.toggle()
                            self.autoComplete()
                        }
                    })
                    .alwaysPopover(isPresented: $showsAlwaysPopover){
                        PopOverView(hasAutoResult: self.$hasAutoResult, autoItems: self.$autoItems, keyword: self.$keyword)
                    }
            }
            
            HStack {
                Text("Distance:")
                    .foregroundColor(.secondary)
                TextField("", text: self.$distance)
            }
            
            HStack {
                Text("Category:")
                    .foregroundColor(.secondary)
                Picker("", selection: self.$category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
            }
            .pickerStyle(.menu)
            
            if !self.checked { // if auto-detect, hide location
                HStack {
                    Text("Location:")
                        .foregroundColor(.secondary)
                    TextField("", text: self.$location)
                }
            }
            
            Toggle(isOn: $checked) {
                Text("Auto-detect my location")
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 30) {
                // Submit button
                Button(action: {
                    self.submitted = true
                    self.results = []
                    if self.checked {
                        self.getCurrentLocation()
                    }
                    else {
                        self.getGeoLocation()
                    }
                }) {
                    Text("Submit")
                        .frame(width: 70 , height: 20, alignment: .center)
                }
                .foregroundColor(Color.white)
                .buttonStyle(.bordered)
                // todo: color change
                .background(buttonColor)
                .controlSize(.large)
                .cornerRadius(10)
                .disabled(!formIsValid)
                
                // Clear button
                Button(action: {
                    self.keyword = ""
                    self.distance = "10"
                    self.category = "Default"
                    self.location = ""
                    self.checked = false
                    self.submitted = false
                    self.hasYelpResult = false
                    self.hasAutoResult = false
                }) {
                    Text("Clear")
                        .frame(width: 70 , height: 20, alignment: .center)
                }
                .foregroundColor(Color.white)
                .buttonStyle(.bordered)
                .background(Color.blue)
                .controlSize(.large)
                .cornerRadius(10)
            }.frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
