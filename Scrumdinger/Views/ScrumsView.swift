//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2022-12-30.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    
    var body: some View {
        List {
            ForEach(scrums) // DailyScrum conforms to Identifiable so no need for id:.
            { scrum in
                CardView(scrum: scrum)
                    .listRowBackground(scrum.theme.mainColor)
                    .frame(height: 60)
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: DailyScrum.sampleData)
    }
}
