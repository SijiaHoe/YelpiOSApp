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
            }
            
            if submitted && hasResults{
                List {
                    ForEach(results.indices) { i in
                        NavigationLink(destination: DetailTabView(id: results[i].id)) {
                            Text(String(i+1))
                                .frame(width: 50)
                            Spacer()
                            
                            AsyncImage(url: URL(string: results[i].photo)){ image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            
                            Text(results[i].bName)
                                .foregroundColor(.gray)
                                .frame(width: 120, alignment: .leading)
                            
                            Text(results[i].rating)
                                .frame(width: 70)
                            Text(results[i].distance)
                        }
                    }
                }
            }
            //            Text("No result available")
            //                .foregroundColor(.red)
            //                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
