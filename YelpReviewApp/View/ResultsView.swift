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
        NavigationView {
            Text("s")
                .navigationTitle("Results")
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
