//
//  ResultsView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI

struct ResultsView: View {
    @Binding var hasResults: Bool
    @Binding var submitted: Bool
    @Binding var results: [BusinessViewModel]
    
    var body: some View {
        Section {
            Text("Results")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if submitted && !hasResults{
                ProgressView("Please wait...")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            if submitted && hasResults{
                if results.count == 0 {
                    Text("No result available")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                else{
                    List {
                        ForEach(results.indices) { i in
                            NavigationLink(destination: DetailTabView(id: results[i].id)) {
                                Text(String(i+1))
                                    .frame(width: 40)
                                
                                AsyncImage(url: URL(string: results[i].photo)){ image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 60, height: 60)
                                .cornerRadius(10)
                                
                                Text(results[i].bName)
                                    .foregroundColor(.gray)
                                    .frame(width: 80, alignment: .center)
                                    .padding(.leading)
                                
                                Text(results[i].rating)
                                    .bold()
                                    .frame(width: 40)
                                Text(results[i].distance)
                                    .bold()
                            }
                        }
                    }
                }
            }
        }
    }
}
