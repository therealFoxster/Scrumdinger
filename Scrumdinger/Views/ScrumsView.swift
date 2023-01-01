//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2022-12-30.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    
    var body: some View {
        List {
            ForEach($scrums) // DailyScrum conforms to Identifiable so no need for id:.
            { $scrum in
                NavigationLink {
                    DetailView(scrum: $scrum)
                } label: {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
        }
        .navigationTitle("Daily Scrums")
        .toolbar {
            Button {
                
            } label: {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")

        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.sampleData))
        }
    }
}
