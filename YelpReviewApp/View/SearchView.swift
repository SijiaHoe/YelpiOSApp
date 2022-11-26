//
//  SearchView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var searchVM = SearchViewModel()
    
//    var categories: String {
//        switch pickerIndex{
//            case 1:
//                return "all"
//            case 2:
//                return "arts"
//            case 3:
//                return "health"
//            case 4:
//                return "hotelstravel"
//            case 5:
//                return "food"
//            case 6:
//                return "professional"
//            default:
//                return "all"
//        }
//    }
    
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
        Form {
            Section{
                HStack {
                    Text("Keyword:")
                    TextField("Required", text: $searchVM.keyword)
                }
                
                HStack {
                    Text("Distance:")
                    TextField("", text: $searchVM.distance)
                }
                
                Picker("Category:", selection: $searchVM.category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                
                if !searchVM.checked { // if auto-detect, hide location
                    HStack {
                        Text("Location:")
                        TextField("", text: $searchVM.location)
                    }
                }
                
                Toggle(isOn: $searchVM.checked) {
                    Text("Auto-detect my location")
                }
                
                HStack(spacing: 30) {
                    // Submit button
                    Button(action: {
                        
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
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
