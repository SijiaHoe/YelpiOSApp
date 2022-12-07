//
//  ReserveListView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 12/3/22.
//

import SwiftUI

struct ReserveListView: View {
    @AppStorage("res") var reservationList: Data?
    @State var hasResult: Bool = false
    
    var body: some View {
        VStack{
            if !hasResult {
                Text("No bookings found")
                    .foregroundColor(.red)
            }
            else{
                List{
                    HStack{
                        Text("sdasd")
                        Text("1212-23-21")
                        Text("10:00")
                        Text("hsu@hs.com")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .navigationTitle("Your Reservations")
    }
}
