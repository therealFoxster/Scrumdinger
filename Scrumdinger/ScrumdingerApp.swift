//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2022-12-29.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
