//
//  ProfileView.swift
//  jr-ios
//
//  Created by Haotian Li on 3/12/25.
//

import SwiftUI

let sampleProfile = {
    Person(name: "Josh Li", time: 100, profileImage: "cat2")
}

struct ProfileView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    Image("")
                }
            }
        }
    }
}


#Preview {
    MainView()
}
