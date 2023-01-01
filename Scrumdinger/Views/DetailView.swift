//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2022-12-30.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var data = DailyScrum.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            // MARK: Meeting info.
            Section {
                NavigationLink {
                    MeetingView()
                } label: {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor) // Use accent color for interactive elements.
                }

                HStack {
                    Label("Length", systemImage: "clock")
                    
                    Spacer()
                    
                    Text("\(scrum.lengthInMinutes) minute\(scrum.lengthInMinutes != 1 ? "s" : "")")
                }
                // Combine Label & Text elements for accessiblity users.
                .accessibilityElement(children: .combine)
                // VoiceOver reads "Length, 10 minutes."
                // Without the modifier, VoiceOver users have to swipe through each element in order for them to be read.
                
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    
                    Spacer()
                    
                    Text(scrum.theme.name)
                        .padding(6)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(6)
                }
            } header: {
                Text("Meeting Info")
            }

            // MARK: Attendees.
            Section {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            } header: {
                Text("Attendees")
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = scrum.data
            }
        }
        // Presents sheet (DetailEditView) when isPresentingEditView is true.
        .sheet(isPresented: $isPresentingEditView) {
            // Embed in different NavigationView because should show different toolbar actions when user is editing compared to viewing.
            NavigationView {
                DetailEditView(data: $data)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                scrum.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
