//
//  CommentView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI

struct CommentView: View {
    var body: some View {
        Section {
            VStack{
                VStack {
                    HStack {
                        Text("name")
                        Spacer()
                        Text("rating")
                    }
                    Text("review")
                        .foregroundColor(.gray)
                    Text("time")
                }
                
                VStack {
                    HStack {
                        Text("name")
                        Spacer()
                        Text("rating")
                    }
                    Text("review")
                        .foregroundColor(.gray)
                    Text("time")
                }
                
                VStack {
                    HStack {
                        Text("name")
                        Spacer()
                        Text("rating")
                    }
                    Text("review")
                        .foregroundColor(.gray)
                    Text("time")
                }
            }
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
