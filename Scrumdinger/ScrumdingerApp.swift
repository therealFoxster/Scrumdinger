//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2022-12-29.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: DailyScrum.sampleData)
            }
        }
    }
}
