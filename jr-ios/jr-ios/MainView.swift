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
            // TODO: replace competitionview placeholder
            ContentView()
                .tabItem{
                    Label("Tab2", systemImage: "command")
                }
            
        }
        
    }
}

#Preview {
    MainView()
}
