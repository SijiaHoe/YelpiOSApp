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
    var body: some View {
        VStack {
            Form {
                Section{
                    Text("Reservation Form")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section {
                    Text("Title")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section {
                    HStack{
                        Text("Email:")
                        TextField("Required", text: $email)
                    }
                    
                    HStack {
                        Text("Date/Time:")
                        DatePicker("", selection: $date, displayedComponents: .date)
                    }
                    
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
            
        }
    }
}

struct ReservationsView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationsView()
    }
}
