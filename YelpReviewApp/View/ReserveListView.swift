//
//  ReserveListView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 12/3/22.
//

import SwiftUI

struct ReserveListView: View {
    var body: some View {
        Text("Your Reservations")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
        Form {
            Section {
                Text("sd")
            }
        }
    }
}

struct ReserveListView_Previews: PreviewProvider {
    static var previews: some View {
        ReserveListView()
    }
}
