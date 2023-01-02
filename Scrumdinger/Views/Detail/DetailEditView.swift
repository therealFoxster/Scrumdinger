//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2022-12-31.
//

import SwiftUI

struct DetailEditView: View {
    // Source of truth for value types.
    @Binding var data: DailyScrum.Data
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            // MARK: Title & meeting length.
            Section {
                TextField("Title", text: $data.title)
                
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
                        Text("Length") // Doesn't appear on the screen but used by VoiceOver.
                    }
                    .accessibilityLabel("\(Int(data.lengthInMinutes)) minute\(data.lengthInMinutes != 1 ? "s" : "")")
                    
                    Spacer()
                    
                    Text("\(Int(data.lengthInMinutes)) minute\(data.lengthInMinutes != 1 ? "s" : "")")
                        .accessibilityHidden(true) // Redundant.
                }
                
                ThemePicker(selection: $data.theme)
            } header: {
                Text("Meeting Info")
            }

            // MARK: Attendees.
            Section {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            data.attendees.append(attendee)
                            newAttendeeName = "" // Also clears content of text field because it has a binding to newAttendeeName.
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty) // Disable button if no name was entered.

                }
            } header: {
                Text("Attendees")
            }
        }
        .navigationTitle(data.title)
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}
