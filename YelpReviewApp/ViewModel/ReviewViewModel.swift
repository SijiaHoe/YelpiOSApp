//
//  ReviewModel.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import Foundation
import SwiftyJSON

class ReviewViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var rating: String = ""
    @Published var review: String = ""
    @Published var date: String = ""
    
    // TODO: get id from nav bar
    var id = ""
    
    func getReview() {
        let url = URL(string: "https://csci571hw8-367920.uw.r.appspot.com/reviews?id=\(id)")!
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
