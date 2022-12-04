//
//  ResultsView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var BusinessVM = BusinessViewModel()
    
    var body: some View {
        Section{
            Text("Results")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            List {
                NavigationLink(destination: Text("Second View")) {
                    Text("1")
                    Image("Twitter")
                        .resizable()
                        .frame(width: 50.0, height: 50.0)
                    Text("name")
                        .foregroundColor(.gray)
                    Text("Rating")
                    Text("6")
                }
                
            }
            
            Text("No result available")
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
