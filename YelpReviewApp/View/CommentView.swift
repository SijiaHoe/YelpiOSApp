//
//  CommentView.swift
//  YelpReviewApp
//
//  Created by LilHoe on 11/25/22.
//

import SwiftUI
import SwiftyJSON

struct CommentView: View {
    @ObservedObject var commentVM = CommentViewModel()
    @Binding var id: String
    @State var hasComment: Bool = false
    @State var results: [CommentViewModel] = []
    
    // call Yelp API to get comments
    func getComments() {
        let url = URL(string: ("https://csci571hw8-367920.uw.r.appspot.com/reviews?id=\(id)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        self.results = []
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data {
                do {
                    let dataString = try JSON(data: data)
                    let raw = dataString["reviews"]
                    for i in raw {
                        let review: CommentViewModel = CommentViewModel()
                        review.name = i.1["user"]["name"].stringValue
                        review.rating = i.1["rating"].stringValue
                        review.text = i.1["text"].stringValue
                        review.time = i.1["time_created"].stringValue.components(separatedBy: " ")[0]
                        self.results.append(review)
                    }
                    self.hasComment = true
                }
                catch {
                    print("error")
                }
            }
        }
        task.resume()
    }
    
    var body: some View {
        Section {
            VStack{
                if !hasComment{
                    Text("")
                        .onAppear {
                            getComments()
                        }
                }
                else{
                    List{
                        ForEach(results.indices, id: \.self) { i in
                            VStack {
                                HStack {
                                    Text(results[i].name)
                                        .bold()
                                    Spacer()
                                    Text(results[i].rating + "/5")
                                        .bold()
                                        .padding(.trailing)
                                }
                                .padding([.leading, .bottom, .top])
                                Text(results[i].text)
                                    .foregroundColor(.gray)
                                    .padding([.leading, .bottom])
                                Text(results[i].time)
                                    .padding([.leading, .bottom])
                            }
                        }
                    }
                }
            }
        }
    }
}
