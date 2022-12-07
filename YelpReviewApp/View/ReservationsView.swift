//
//  ReservationsView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/21/22.
//

import SwiftUI

struct ReservationsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var isInvalidEmail: Bool = false
    @State var isSuccess: Bool = false
    
    @Binding var id: String
    @Binding var name: String
    @Binding var isReserved: Bool
    
    @State var date: Date = Date()
    @State var email: String = ""
    @State var hour: String = "10"
    @State var minute: String = "00"
    
    @AppStorage("res") var reservationList: Data?
    
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
                    Text(self.name)
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section {
                    HStack {
                        Text("Email:")
                            .foregroundColor(.secondary)
                        TextField("Required", text: self.$email)
                            .foregroundColor(.black)
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Text("Date/Time:")
                            .foregroundColor(.secondary)
                            .frame(width: 45)
                        
                        // disable days before today
                        DatePicker("", selection: self.$date, in: Date()..., displayedComponents: .date)
                        
                        // hour picker
                        Menu {
                            ForEach(hours, id: \.self) { hour in
                                Button(action: {
                                    self.hour = hour
                                }){
                                    Text(hour)
                                }
                            }
                        }label: {
                            Text(self.hour)
                                .foregroundColor(.primary)
                        }
                        
                        Text(":")
                            .foregroundColor(.secondary)
                        
                        // minute picker
                        Menu {
                            ForEach(minutes, id: \.self) { minute in
                                Button(action: {
                                    self.minute = minute
                                }){
                                    Text(minute)
                                }
                            }
                        }label: {
                            Text(self.minute)
                                .foregroundColor(.primary)
                                .frame(alignment: .leading)
                        }
                    }
                    .padding(.vertical)
                    
                    // Submit button
                    HStack {
                        Button(action: {
                            // validate email
                            if(self.email.range(of:"^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$", options: .regularExpression) != nil) {
                                self.isInvalidEmail = false
                                
                                // add reservation to local storage
                                var r = Reservation()
                                r.email = self.email
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "YYYY-MM-dd"
                                // Convert Date to String
                                r.date = dateFormatter.string(from: self.date)
                                r.time = self.hour + ":" + self.minute
                                r.bName = self.name
                                
                                do{
                                    if (reservationList == nil) {
                                        let data = try? JSONEncoder().encode([self.id: r])
                                        reservationList = data
                                    }
                                    else {
                                        var data = try JSONDecoder().decode(Dictionary<String, Reservation>.self, from: reservationList!)
                                        data[self.id] = r
                                        print(data)
                                        reservationList = try? JSONEncoder().encode(data)
                                    }
                                } catch {
                                    print("error")
                                }
                                
                                // successfully reserved view pop up
                                self.isSuccess = true
                            }
                            else {
                                self.isInvalidEmail = true
                            }
                        }) {
                            Text("Submit")
                                .frame(width: 70 , height: 20, alignment: .center)
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
            SuccessReservedView(isReserved: self.$isReserved)
        }
    }
}
