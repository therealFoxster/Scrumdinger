//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2022-12-29.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    // Save action.
                    Task { // Asynchronus context (work).
                        do {
                            try await ScrumStore.save(scrums: store.scrums)
                        } catch {
                            fatalError("Unable to save scrums.")
                        }
                    }
                    
//                    ScrumStore.save(scrums: store.scrums) { result in
//                        if case .failure(let error) = result {
//                            fatalError(error.localizedDescription)
//                        }
//                    }
                }
            }
            .task { // Asynchronus task to perform before view appears.
                do {
                    store.scrums = try await ScrumStore.load()
                } catch {
                    fatalError("Unable to load scrums.")
                }
            }
//            .onAppear {
//                ScrumStore.load { result in
//                    switch result {
//                    case .success(let scrums):
//                        store.scrums = scrums
//                    case .failure(let error):
//                        fatalError(error.localizedDescription)
//                    }
//                }
//            }
        }
    }
}
