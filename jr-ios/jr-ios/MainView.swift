//
//  MainView.swift
//  jr-ios
//
//  Created by Tongsheng Wu on 2/3/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
        }
        
    }
}

#Preview {
    MainView()
}
