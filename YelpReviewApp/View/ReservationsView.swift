//
//  ReservationsView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/21/22.
//

import SwiftUI

struct ReservationsView: View {
    @State var email: String = ""
    @State var date: Date = Date()
    @State var isInvalidEmail: Bool = false
    
    var body: some View {
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
                        
                    }) {
                        Text("Submit")
                            .frame(width: 70 , height: 20, alignment: .center)
                    }
                    .foregroundColor(Color.white)
                    .buttonStyle(.bordered)
                    // todo: color change
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
}

struct ReservationsView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationsView()
    }
}
