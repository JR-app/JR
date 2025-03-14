//
//  FocusView.swift
//  jr-ios
//
//  Created by Tongsheng Wu on 3/3/25.
//

import SwiftUI


struct PopupView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
            VStack (){
                Button(action: {
                    isPresented = false
                })
                    {
                        Text("Block")
                    }
                Button(action: {
                    isPresented = false
                }) {
                    Text("Close")
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 16)
        }
    
}

struct FocusView: View {
    @State private var isPopupPresented = false
    var body: some View {
        ZStack {
            VStack {
                Text("Main")
                Button(action: {
                    isPopupPresented = true
                }) {
                    Text("Show Popup")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            if isPopupPresented {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPopupPresented = false
                    }
                PopupView(isPresented: $isPopupPresented)
                    .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2.5)
            }
        }
    }
}


#Preview {
    MainView()
}
