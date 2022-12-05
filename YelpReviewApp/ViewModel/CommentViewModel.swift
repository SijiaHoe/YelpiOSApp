//
//  CommentViewModel.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import Foundation
import SwiftyJSON

class CommentViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var rating: String = ""
    @Published var text: String = ""
    @Published var time: String = ""
    
    // TODO: get id from nav bar
    var id = ""
    
    func getComments() -> [CommentViewModel] {
        id = "vWpuRdatiCaxbdqhbqX0rw"
        let url = URL(string: "https://csci571hw8-367920.uw.r.appspot.com/reviews?id=\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        var reviews: [CommentViewModel] = []
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
                    let raw = dataString["reviews"]
                    for i in raw {
                        let review: CommentViewModel = CommentViewModel()
                        review.name = i.1["user"]["name"].stringValue
                        review.rating = i.1["rating"].stringValue
                        review.text = i.1["text"].stringValue
                        review.time = i.1["time_created"].stringValue.components(separatedBy: " ")[0]
                        reviews.append(review)
                    }
                }
                catch {
                    print("error")
                }
            }
        }
        task.resume()
        return reviews
    }
}
