//
//  ContentView.swift
//  jr-ios
//
//  Created by Tongsheng Wu on 3/2/25.
//

import SwiftUI

struct ContentView: View {
    @State var topBarShown = false
    
    var body: some View {
        ZStack {
            VStack {
                TopBarView(topBarShown: $topBarShown)
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, JR!")
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    MainView()
}
