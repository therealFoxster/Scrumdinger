//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2022-12-30.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresentingNewScrumView = false
    @State private var newScrumData = DailyScrum.Data() // Source of truth for all of the changes made to the new scrum.
    
    let saveAction: () -> Void
    
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
            .onDelete { indexSet in
                scrums.remove(atOffsets: indexSet)
            }
        }
        .background {
            if scrums.isEmpty {
                ZStack {
                    Color.red.opacity(0) // Fill screen with transparent color (which will center VStack).
                    VStack {
                        Text("No Scrums")
                            .font(.title2)
                            .bold()
                        Text("Tap the \"+\" icon to add a scrum.")
                            .foregroundColor(.secondary)
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .navigationTitle("Daily Scrums")
        .toolbar {
            Button {
                isPresentingNewScrumView = true // Triggers sheet to create new scrum (DetailEditView).
            } label: {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")

        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NavigationView {
                DetailEditView(data: $newScrumData).toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewScrumView = false // Triggers sheet to hide.
                            newScrumData = DailyScrum.Data() // Discards newScrumData.
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            let newScrum = DailyScrum(data: newScrumData)
                            scrums.append(newScrum) // Updates source of truth (initialized in ScrumdingerApp)
                            isPresentingNewScrumView = false
                            newScrumData = DailyScrum.Data()
                        }
                    }
                }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive // Scene is visible not not interactive (e.g. in app switcher).
            {
                saveAction()
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
//            ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
            ScrumsView(scrums: .constant([]), saveAction: {})
        }
    }
}
