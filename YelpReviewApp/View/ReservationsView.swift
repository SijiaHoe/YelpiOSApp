//
//  ReservationsView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/21/22.
//

import SwiftUI

struct ReservationsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var email: String = ""
    @State var date: Date = Date()
    @State var isInvalidEmail: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        if !self.isSuccess {
            Form {
                Section{
                    Text("Reservation Form")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section {
                    Text("Title")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section {
                    HStack{
                        Text("Email:")
                            .foregroundColor(.black)
                        TextField("Required", text: $email)
                            .foregroundColor(.black)
                    }
                    
                    HStack {
                        Text("Date/Time:")
                            .foregroundColor(.black)
                        DatePicker("", selection: $date, displayedComponents: .date)
                    }
                    
                    // Submit button
                    HStack {
                        Button(action: {
                            // validate email
                            
                            // valid email, successfully reserved
                            self.isSuccess = true
                            
                        }) {
                            Text("Submit")
                                .frame(width: 70 , height: 20, alignment: .center)
                        }
                        .sheet(isPresented: self.$isSuccess){
                            SuccessReservedView()
                        }
                        .foregroundColor(Color.white)
                        .buttonStyle(.bordered)
                        .background(.blue)
                        .controlSize(.large)
                        .cornerRadius(10)
                    }.frame(maxWidth: .infinity, alignment: .center)
                }
            }
            // add message to show email is not valid
            .toast(isPresented: self.$isInvalidEmail) {
                Text("Please enter a valid email.")
            }
        }
        else{
            SuccessReservedView()
        }
    }
}
//
struct ReservationsView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationsView()
    }
}
