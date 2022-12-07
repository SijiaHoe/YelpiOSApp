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
    @State var table: Dictionary<String, Reservation> = [:]
    
    var body: some View {
        VStack{
            if !hasResult {
                Text("No bookings found")
                    .foregroundColor(.red)
            }
            else{
                List{
                    ForEach(Array(table.keys.sorted()), id: \.self) { key in
                        HStack{
                            Text(table[key]!.bName)
                                .font(.footnote)
                                .frame(width: 70, alignment: .leading)
                            Text(table[key]!.date)
                                .font(.footnote)
                            Text(table[key]!.time)
                                .font(.footnote)
                                .frame(width: 40)
                            Text(table[key]!.email)
                                .font(.footnote)
                                .foregroundColor(.black)
                                .frame(alignment: .leading)
                        }
                    }
                    .onDelete { index in
                        let key = table.keys.sorted()[index.first!]
                        table.removeValue(forKey: key)
                        reservationList = try? JSONEncoder().encode(table)
                        if table.count == 0 {
                            self.hasResult = false
                        }
                    }
                }
            }
        }
        .onAppear {
            do{
                let data = try JSONDecoder().decode(Dictionary<String, Reservation>.self, from: reservationList!)
                // if local storage has data, render the table
                if data.count != 0 {
                    self.table = data
                    self.hasResult = true
                }
            }
            catch {
                print("error")
            }
        }
        .navigationTitle("Your Reservations")
    }
}
