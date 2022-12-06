//
//  PopOverView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 12/5/22.
//

import SwiftUI

struct PopOverView: View {
    @Binding var hasAutoResult: Bool
    @Binding var autoItems: [String]
    @Binding var keyword: String
    
    var body: some View {
        if !self.hasAutoResult {
            ProgressView("Loading...")
                .padding()
                .id(UUID())
        }
        else {
            VStack {
                ForEach(autoItems, id: \.self) { item in
                    Button(action: {
                        self.keyword = item
                    }){
                        Text(item)
                    }
                    .foregroundColor(.secondary)
                }
            }
            .font(.subheadline)
            .padding()
        }
    }
}
