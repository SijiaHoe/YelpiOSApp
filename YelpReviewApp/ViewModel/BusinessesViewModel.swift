//
//  BusinessesViewModel.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import Foundation

class BusinessViewModel: ObservableObject, Identifiable {
    var id: String = ""
    @Published var photo: String = ""
    @Published var bName: String = ""
    @Published var rating: String = ""
    @Published var distance: String = ""
}
