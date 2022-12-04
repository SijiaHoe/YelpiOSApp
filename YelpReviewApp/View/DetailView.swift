//
//  DetailView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack(spacing: 50) {
            HStack{
                Text("**Title**")
                    .font(.largeTitle)
            }
            HStack {
                VStack {
                    Text("**Address**")
                    Text("R 1, C 2")
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack {
                    Text("**Category**")
                    Text("Row 2")
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                VStack {
                    Text("**Phone**")
                    Text("R 1, C 2")
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack {
                    Text("**Price Range**")
                    Text("Row 2")
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                VStack {
                    Text("**Status**")
                    Text("ed")
                }
                // status color change
                Spacer()
                VStack {
                    Text("**Visit Yelp for more**")
                    Text("dsf")
                        .foregroundColor(.blue)
                }
            }
            
            // Reserve button
            HStack {
                Button(action:{
                    
                }){
                    Text("Reserve Now")
                        .frame(width: 100 , height: 20, alignment: .center)
                }.foregroundColor(Color.white)
                    .buttonStyle(.bordered)
                    .background(Color.red)
                    .controlSize(.large)
                    .cornerRadius(15)
            }
            
            // Social Media
            HStack {
                Text("**Share on:**")
                Button(action: {
                    
                }) {
                    Image("facebook")
                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .resizable()
                        .frame(width: 50.0, height: 50.0)
                }
                Button(action: {
                    
                }) {
                    Image("twitter")
                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .resizable()
                        .frame(width: 50.0, height: 50.0)
                }
            }
            
            // Images
            HStack{
                TabView {
                    Text("First")
                    Text("Second")
                    Text("Third")
                    Text("Fourth")
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
