//
//  File.swift
//  YelpReviewApp
//
//  Created by LilHoe on 12/4/22.
//

import Foundation

class ReserveViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var date: String = ""
    @Published var hour: String = "10"
    @Published var minute: String = "00"
}
