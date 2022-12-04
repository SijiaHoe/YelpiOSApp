//
//  ContentView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/15/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Form {
                Section{
                    SearchView()
                }
                ResultsView()
            }
            .navigationTitle("Business Search")
            .toolbar {
                NavigationLink(destination: ReserveListView())
                {
                    Image(systemName: "calendar.badge.clock")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
