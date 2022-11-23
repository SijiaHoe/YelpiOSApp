//
//  ContentView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/15/22.
//

import SwiftUI

struct ContentView: View {
    @State var keyword: String = ""
    @State var distance: String = "10"
    @State var categories: String = "all"
    @State var location: String = ""
    @State var checked: Bool = false
    var body: some View {
        NavigationView{
            // search setion
            VStack{
                Form {
                    Section{
                        HStack {
                            Text("Keyword:")
                            TextField("Required", text: $keyword)
                        }
                        HStack {
                            Text("Distance:")
                            TextField("", text: $distance)
                        }
                        Picker(selection: $categories, label: Text("Category:")) {
                            Text("Default").tag(1)
                            Text("Arts and Entertainment").tag(2)
                            Text("Health and Medical").tag(3)
                            Text("Hotels and Travel").tag(4)
                            Text("Food").tag(5)
                            Text("Professional Services").tag(6)
                        }
                        HStack {
                            Text("Location:")
                            TextField("", text: $location)
                        }
                        Toggle(isOn: $checked) {
                            Text("Auto-detect my location")
                        }
                        HStack(spacing: 30) {
                            Button(action: {
                                
                            }) {
                                Text("Submit")
                                    .frame(width: 70 , height: 20, alignment: .center)
                            }
                            .foregroundColor(Color.white)
                            .buttonStyle(.bordered)
                            // todo: color change
                            .background(Color.red)
                            .controlSize(.large)
                            .cornerRadius(10)
                            
                            Button(action: {
                                
                            }) {
                                Text("Clear")
                                    .frame(width: 70 , height: 20, alignment: .center)
                            }
                            .foregroundColor(Color.white)
                            .buttonStyle(.bordered)
                            .background(Color.blue)
                            .controlSize(.large)
                            .cornerRadius(10)
                        }.frame(maxWidth: .infinity, alignment: .center)
                    }
                }
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
            
            // search results section
            VStack {
                List {
                    
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
