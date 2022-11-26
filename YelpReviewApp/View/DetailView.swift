//
//  DetailView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI

struct DetailView: View {
    @State private var showSheet: Bool = false
    @ObservedObject var detailVM = DetailViewModel()
    
    var body: some View {
        VStack(spacing: 50) {
            HStack{
                Text("Title")
                    .font(.largeTitle)
                    .bold()
            }
            HStack {
                VStack {
                    Text("**Address**")
                    Text(detailVM.address)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack {
                    Text("**Category**")
                    Text(detailVM.category)
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                VStack {
                    Text("**Phone**")
                    Text(detailVM.phone)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack {
                    Text("**Price Range**")
                    Text(detailVM.price)
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                VStack {
                    Text("**Status**")
                    Text(detailVM.status)
                }
                // status color change
                Spacer()
                VStack {
                    Text("**Visit Yelp for more**")
                    Text(detailVM.link)
                        .foregroundColor(.blue)
                }
            }
            
            // Reserve button
            HStack {
                Button(action:{
                    showSheet = true
                }){
                    Text("Reserve Now")
                        .frame(width: 100 , height: 20, alignment: .center)
                }.foregroundColor(Color.white)
                    .buttonStyle(.bordered)
                    .background(Color.red)
                    .controlSize(.large)
                    .cornerRadius(15)
                    .sheet(isPresented: $showSheet, content: {
                        ReservationsView()
                    })
            }
            
            // Social Media
            HStack {
                Text("**Share on:**")
                // facebook
                Link(destination: URL(string: "https://www.facebook.com/sharer/sharer.php?u=\(detailVM.link)&quote=Check \(detailVM.bName) on Facebook.")!){
                    Button(action: {
                        
                    }) {
                        Image("facebook")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            .resizable()
                            .frame(width: 50.0, height: 50.0)
                    }
                }
                
                // twitter
                Link(destination: URL(string: "https://twitter.com/intent/tweet?text=Check \(detailVM.bName) on Yelp.&url=\(detailVM.link)")!){
                    Button(action: {
                        
                    }) {
                        Image("twitter")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            .resizable()
                            .frame(width: 50.0, height: 50.0)
                    }
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
