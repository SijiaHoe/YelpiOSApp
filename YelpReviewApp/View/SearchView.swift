//
//  SearchView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var searchVM = SearchViewModel()
    @State var showsAlwaysPopover: Bool = false
    @State var autoItems: [String] = []
    
    let categories = ["Default", "Arts and Entertainment", "Health and Medical", "Hotels and Travel", "Food", "Professional Services"]
    // Form validation
    var formIsValid: Bool {
        return !searchVM.keyword.isEmpty && !searchVM.distance.isEmpty && (!searchVM.location.isEmpty || searchVM.checked)
    }
    var buttonColor: Color {
        return formIsValid ? .red : .gray
    }
    
    var body: some View {
        // search setion
        Section{
            HStack {
                Text("Keyword:")
                    .foregroundColor(.secondary)
                // add autocomplete popOver
                TextField("Required", text: $searchVM.keyword)
                    .onChange(of: searchVM.keyword, perform: { newValue in
                        if searchVM.keyword.count == 0 {
                            showsAlwaysPopover = false
                        }
                        else {
                            showsAlwaysPopover.toggle()
                        }
                    })
                    .alwaysPopover(isPresented: $showsAlwaysPopover){
                        PopoverContent()
                    }
            }
            
            HStack {
                Text("Distance:")
                    .foregroundColor(.secondary)
                TextField("", text: $searchVM.distance)
            }
            
            HStack {
                Text("Category:")
                    .foregroundColor(.secondary)
                Picker("", selection: $searchVM.category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
            }
            .pickerStyle(.menu)
            
            if !searchVM.checked { // if auto-detect, hide location
                HStack {
                    Text("Location:")
                        .foregroundColor(.secondary)
                    TextField("", text: $searchVM.location)
                }
            }
            
            Toggle(isOn: $searchVM.checked) {
                Text("Auto-detect my location")
                    .foregroundColor(.secondary)
            }
            
            HStack(spacing: 30) {
                // Submit button
                Button(action: {
                    searchVM.submit()
                }) {
                    Text("Submit")
                        .frame(width: 70 , height: 20, alignment: .center)
                }
                .foregroundColor(Color.white)
                .buttonStyle(.bordered)
                // todo: color change
                .background(buttonColor)
                .controlSize(.large)
                .cornerRadius(10)
                .disabled(!formIsValid)
                
                // Clear button
                Button(action: {
                    searchVM.keyword = ""
                    searchVM.distance = "10"
                    searchVM.category = "Default"
                    searchVM.location = ""
                    searchVM.checked = false
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

struct PopoverContent: View {
    var body: some View {
        ProgressView("Loading...")
        Text("This should be presented\nin a popover.")
            .font(.subheadline)
            .padding()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
