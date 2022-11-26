//
//  ReviewModel.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import Foundation

class ReviewViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var rating: String = ""
    @Published var review: String = ""
    @Published var date: String = ""
    
    func getReview() {
        
    }
}
