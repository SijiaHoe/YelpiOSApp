//
//  SuccessReservedView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 12/3/22.
//

import SwiftUI

struct SuccessReservedView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            Text("Congratulations!")
                .bold()
                .padding(.bottom)
            Text("You have successfully made an reservation at")
            Text("sdsds")
            Spacer()
            // Done button
            Button(action: {
                dismiss()
            }){
                Text("Done")
                    .frame(width: 170 , height: 20, alignment: .center)
            }
            .foregroundColor(.green)
            .buttonStyle(.bordered)
            // todo: color change
            .background(.white)
            .controlSize(.large)
            .cornerRadius(30)
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
