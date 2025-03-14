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
        ZStack{
            VStack (){
                closeButton
                Spacer()
                startButton
                Spacer().frame(height: 75)
            }
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 16)
        }
    }
    var closeButton: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isPresented = false;
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 27.0, height: 27.0)
                        .padding(10)
                }
            }
            .padding(.top, 5)
        }
    
    }
    var startButton: some View {
        HStack {
            Spacer()
            Button(action: {
                
            }) {
                Text("Start")
                    .font(.system(size:22))
                    .padding(.horizontal, 30)
                    .padding(.vertical, 8)
                    .background(Color(red: 30/255, green: 30/255, blue: 30/255))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Spacer()
        }
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
