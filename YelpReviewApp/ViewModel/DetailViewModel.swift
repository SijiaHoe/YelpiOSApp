//
//  DetailModel.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import Foundation
import SwiftyJSON

class DetailViewModel: ObservableObject {
    @Published var bName: String = ""
    @Published var address: String = ""
    @Published var category: String = ""
    @Published var phone: String = ""
    @Published var price: String = ""
    @Published var status: String = ""
    @Published var link: String = ""
    var id: String = ""
    
    // TODO: get map pin location
    
    func getDetail() {
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
                    self.bName = dataString["name"].stringValue
                    
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
