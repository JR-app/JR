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
            // TODO: replace competitionview placeholder
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            FocusView()
                .tabItem{
                    Label("Focus", systemImage: "command")
                }
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "command")
                }
        }
        
    }
}

#Preview {
    MainView()
}
