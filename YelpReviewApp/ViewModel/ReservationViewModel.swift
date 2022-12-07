//
//  ReservationViewModel.swift
//  YelpReviewApp
//
//  Created by LilHoe on 12/6/22.
//

import Foundation

struct Reservation: Codable, Equatable {
    var email: String = ""
    var date: String = ""
    var time: String = ""
    var bName: String = ""
}
