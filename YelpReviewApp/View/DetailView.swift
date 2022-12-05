//
//  DetailView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var detailVM = DetailViewModel()
    @State private var showSheet: Bool = false
    @State private var status: Bool = true
    @State private var isReserved: Bool = false
    @State private var isCancelled: Bool = false
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Title")
                .font(.largeTitle)
                .bold()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("**Address**")
                    Text("R 1, C 2")
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("**Category**")
                    Text("Row 2")
                        .foregroundColor(.gray)
                }
            }
            .padding([ .trailing, .leading])
            
            HStack {
                VStack(alignment: .leading) {
                    Text("**Phone**")
                    Text("R 1, C 2")
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("**Price Range**")
                    Text("Row 2")
                        .foregroundColor(.gray)
                }
            }
            .padding([ .trailing, .leading])
            
            HStack {
                // TODO: status color change
                VStack(alignment: .leading) {
                    Text("**Status**")
                    if self.status {
                        Text("Open Now")
                            .foregroundColor(.green)
                    }
                    else {
                        Text("Closed")
                            .foregroundColor(.red)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("**Visit Yelp for more**")
                    Link("Business Link", destination: URL(string: "https://www.simpleswiftguide.com")!)
                }
            }
            .padding([ .trailing, .leading])
            
            HStack {
                // Reserve button
                if !self.isReserved{
                    Button(action:{
                        showSheet.toggle()
                    }){
                        Text("Reserve Now")
                            .frame(width: 100 , height: 20, alignment: .center)
                    }
                    .sheet(isPresented: $showSheet){
                        ReservationsView()
                    }
                    .foregroundColor(Color.white)
                    .buttonStyle(.bordered)
                    .background(Color.red)
                    .controlSize(.large)
                    .cornerRadius(15)
                }
                // Cancel button
                else {
                    Button(action: {
                        self.isCancelled = true
                        self.isReserved = false
                    }){
                        Text("Cancel Reservation")
                            .frame(width: 148 , height: 20, alignment: .center)
                    }
                    .foregroundColor(Color.white)
                    .buttonStyle(.bordered)
                    .background(Color.blue)
                    .controlSize(.large)
                    .cornerRadius(15)
                }
            }
            
            // Social Media
            HStack {
                Text("**Share on:**")
//            https://www.facebook.com/sharer/sharer.php?u={{link}}&quote=Check {{bName.innerHTML}} on Facebook.
                Link(destination: URL(string: "https://www.apple.com")!) {
                    Image("facebook")
                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .resizable()
                        .frame(width: 50.0, height: 50.0)
                }
//            https://twitter.com/intent/tweet?text=Check {{bName.innerHTML}} on Yelp.&url={{link}}
                Link(destination: URL(string: "https://www.apple.com")!) {
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
            .padding([ .trailing, .leading])
        }
        .toast(isPresented: self.$isCancelled) {
            Text("Your reservation is cancelled.")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
