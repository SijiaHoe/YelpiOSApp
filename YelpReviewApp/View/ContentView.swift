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
            VStack{
                SearchView()
                ResultsView()
            }
                .navigationTitle("Business Search")
                .toolbar {
                    Button(action:{
                    }) {
                        Image(systemName: "calendar.badge.clock")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                    }
                }
        } // Nav
    } // body
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
