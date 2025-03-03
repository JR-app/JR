//
//  CompetitionView.swift
//  jr-ios
//
//  Created by Tongsheng Wu on 3/3/25.
//

import SwiftUI

struct Person {
    var name: String
    var time: Int
    var profileImage: String
}
let dummyData = [
    Person(name: "Alex Huang", time: 20, profileImage: "cat1"),
    Person(name: "Josh Li", time: 100, profileImage: "cat2"),
    Person(name: "Jesse Liu", time: 23, profileImage: "cat3"),
]


struct CompetitionView: View {
    @Binding var currentCompetitionName: String
    var body: some View {
        Text(currentCompetitionName)
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        List {
            Section("diddlers") {
                ForEach(dummyData, id: \.name) { person in
                    PersonCompetitionStatsView(personName: person.name, personTime: person.time, personImage: person.profileImage)
                }
            }
        }
        .listStyle(.plain)
    }
}

struct PersonCompetitionStatsView: View {
    var personName: String
    var personTime: Int
    var personImage: String
    
    var body: some View {
        HStack {
            Image(personImage)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(.circle)
                .overlay{
                    Circle().stroke(lineWidth: 2)
                }
            VStack(alignment: .leading){
                Text(personName)
                Text(String(personTime))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}
#Preview {
    MainView()
}
