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
}
