//
//  SearchView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI

struct SearchView: View {
    @State var keyword: String = ""
    @State var distance: String = "10"
    @State var pickerIndex: Int = 1
    @State var location: String = ""
    @State var checked: Bool = false
    
    var categories: String {
        switch pickerIndex{
            case 1:
                return "all"
            case 2:
                return "arts"
            case 3:
                return "health"
            case 4:
                return "hotelstravel"
            case 5:
                return "food"
            case 6:
                return "professional"
            default:
                return "all"
        }
    }
    // Form validation
    var formIsValid: Bool {
        return !keyword.isEmpty && !distance.isEmpty && (!location.isEmpty || checked)
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
                    TextField("Required", text: $keyword)
                }
                
                HStack {
                    Text("Distance:")
                    TextField("", text: $distance)
                }
                
                Picker("Category:", selection: $pickerIndex) {
                    Text("Default").tag(1)
                    Text("Arts and Entertainment").tag(2)
                    Text("Health and Medical").tag(3)
                    Text("Hotels and Travel").tag(4)
                    Text("Food").tag(5)
                    Text("Professional Services").tag(6)
                }
                .pickerStyle(.menu)
                
                if !checked { // if auto-detect, hide location
                    HStack {
                        Text("Location:")
                        TextField("", text: $location)
                    }
                }
                
                Toggle(isOn: $checked) {
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
                        keyword = ""
                        distance = "10"
                        pickerIndex = 1
                        location = ""
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
