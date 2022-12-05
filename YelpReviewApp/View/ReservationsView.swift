//
//  ReservationsView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/21/22.
//

import SwiftUI

struct ReservationsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var reserveVM = ReserveViewModel()
    
    @State var date: Date = Date()
    @State var isInvalidEmail: Bool = false
    @State var isSuccess: Bool = false
    
    let hours = ["10", "11", "12", "13", "14", "15", "16", "17"]
    let minutes = ["00", "15", "30", "45"]
    
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
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section {
                    HStack {
                        Text("Email:")
                            .foregroundColor(.secondary)
                        TextField("Required", text: $reserveVM.email)
                            .foregroundColor(.black)
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Text("Date/Time:")
                            .foregroundColor(.secondary)
                        
                        // disable days before today
                        DatePicker("", selection: $date, in: Date()..., displayedComponents: .date)
                        
                        HStack {
                            // hour picker
                            Menu {
                                ForEach(hours, id: \.self) { hour in
                                    Button(action: {
                                        reserveVM.hour = hour
                                    }){
                                        Text(hour)
                                    }
                                }
                            }label: {
                                Text(reserveVM.hour)
                                    .foregroundColor(.primary)
                            }
                            
                            Text(":")
                                .foregroundColor(.secondary)
                            
                            // minute picker
                            Menu {
                                ForEach(minutes, id: \.self) { minute in
                                    Button(action: {
                                        reserveVM.minute = minute
                                    }){
                                        Text(minute)
                                    }
                                }
                            }label: {
                                Text(reserveVM.minute)
                                    .foregroundColor(.primary)
                            }
                        }
                        .frame(width:75, height: 35)
                        .background(Color.secondary.colorInvert())
                        .cornerRadius(10)
                    }
                    .padding(.vertical)
                    
                    // Submit button
                    HStack {
                        Button(action: {
                            // validate email
                            if(reserveVM.email.range(of:"^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", options: .regularExpression) != nil) {
                                isInvalidEmail = false
                                // successfully reserved
                                self.isSuccess = true
                            }
                            else {
                                isInvalidEmail = true
                            }
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
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
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
