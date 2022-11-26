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
}
