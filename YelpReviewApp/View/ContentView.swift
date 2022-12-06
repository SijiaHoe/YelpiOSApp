//
//  ContentView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/15/22.
//

import SwiftUI

struct ContentView: View {
    @State var submitted: Bool = false
    @State var hasResults: Bool = false
    @State var results: [BusinessViewModel] = []
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    SearchView(results: self.$results, hasYelpResult: self.$hasResults, submitted: self.$submitted)
                }
                ResultsView(hasResults: self.$hasResults, submitted: self.$submitted, results: self.$results)
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
