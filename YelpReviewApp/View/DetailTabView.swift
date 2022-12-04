//
//  DetailTabView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 12/3/22.
//

import SwiftUI

struct DetailTabView: View {
    var body: some View {
        TabView {
            DetailView()
                .tabItem {
                    Label("Business Detail", systemImage: "text.bubble.fill")
                }
            MapView()
                .tabItem {
                    Label("Map Location", systemImage: "location.fill")
                }
            CommentView()
                .tabItem {
                    Label("Reviews", systemImage: "message.fill")
                }
        }
    }
}

struct DetailTabView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTabView()
    }
}
