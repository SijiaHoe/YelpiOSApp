//
//  ReserveListView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 12/3/22.
//

import SwiftUI

struct ReserveListView: View {
    var body: some View {
        VStack{
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
        .navigationTitle("Your Reservations")
    }
}

struct ReserveListView_Previews: PreviewProvider {
    static var previews: some View {
        ReserveListView()
    }
}
