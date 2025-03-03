//
//  TopBarView.swift
//  jr-ios
//
//  Created by Tongsheng Wu on 3/3/25.
//

import SwiftUI

struct TopBarView: View {
    
    @Binding var topBarShown: Bool
    @State var curGroupName = "Cafe Baits"
    
    var body: some View {
        Button(action: {
            topBarShown.toggle()
        }) {
            HStack {
                Text(curGroupName)
                    .foregroundStyle(Color.black)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.6)
        // TODO: change this button's style
        .buttonStyle(.bordered)
    }
}

#Preview {
    MainView()
}
