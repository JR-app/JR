//
//  ContentView.swift
//  jr-ios
//
//  Created by Tongsheng Wu on 3/2/25.
//

import SwiftUI

struct ContentView: View {
    @State var topBarShown = false
    @State var currentCompetitionName = "competition"
    
    var body: some View {
        ZStack {
            VStack {
                TopBarView(topBarShown: $topBarShown)
                CompetitionView(currentCompetitionName: $currentCompetitionName)
                Spacer()
            }
            .padding()
        }
    }
}


#Preview {
    MainView()
}
