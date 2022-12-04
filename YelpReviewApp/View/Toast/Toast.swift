//
//  Toast.swift
//  YelpReviewApp
//
//  Created by LilHoe on 12/3/22.
//

import SwiftUI

struct Toast<Presenting, Content>: View where Presenting: View, Content: View {
    @Binding var isPresented: Bool
    let presenter: () -> Presenting
    let content: () -> Content
    let delay: TimeInterval = 2
    
    var body: some View {
        if self.isPresented {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.delay) {
                withAnimation {
                    self.isPresented = false
                }
            }
        }
        
        return GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                self.presenter()
                
                ZStack {
                    Capsule()
                        .fill(Color.gray)
                    
                    self.content()
                }
                .frame(width: geometry.size.width / 1.25, height: geometry.size.height / 10)
                .opacity(self.isPresented ? 1 : 0)
            }
            .padding(.bottom)
        } //GeometryReader
    } //body
} //Toast
