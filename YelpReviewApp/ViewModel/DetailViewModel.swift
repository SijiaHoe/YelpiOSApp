//
//  DetailModel.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var bName: String = ""
    @Published var address: String = ""
    @Published var category: String = ""
    @Published var phone: String = ""
    @Published var price: String = ""
    @Published var status: String = ""
    @Published var link: String = ""
    
    
}
