//
//  SuccessReservedView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 12/3/22.
//

import SwiftUI

struct SuccessReservedView: View {
    var body: some View {
        VStack {
            Text("Congratulations!")
                .bold()
                .padding(.bottom)
            Text("You have successfully made an reservation at")
            Text("sdsds")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
        .foregroundColor(.white)
    }

}

struct SuccessReservedView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessReservedView()
    }
}
