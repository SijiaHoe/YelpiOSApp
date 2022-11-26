//
//  SearchModel.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var keyword: String = ""
    @Published var distance: String = "10"
    @Published var category: String = "all"
    @Published var location: String = ""
    @Published var checked: Bool = false
    
    func getCurrentLocation() {
        let url = URL(string: "https://ipinfo.io/json?token=026d73b0fd6fa7")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
            
        }
        task.resume()
    }
    
    func submit() {
        if checked {
            getCurrentLocation()
        }
        
    }
}
