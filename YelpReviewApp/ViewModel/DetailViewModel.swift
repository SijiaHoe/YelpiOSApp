//
//  DetailViewModel.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import Foundation
import CoreLocation

class DetailViewModel: ObservableObject {
    @Published var bName: String = ""
    @Published var address: String = ""
    @Published var category: String = ""
    @Published var phone: String = ""
    @Published var price: String = ""
    @Published var status: String = ""
    @Published var link: String = "https://google.com"
    @Published var photos: [String] = []
    var id: String = ""
    
}
