//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2022-12-29.
//

import SwiftUI

struct MeetingView: View {
    var body: some View {
        VStack {
            ProgressView(value: 5, total: 15)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("300", systemImage: "hourglass.bottomhalf.fill")
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Seconds Remainng")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.tophalf.fill")
                }
            }
            // Ignore inferred accessibility labels.
            .accessibilityElement(children: .ignore)
            // Manually add accessibility label & value.
            .accessibilityLabel("Time remaining")
            .accessibilityValue("10 minutes")
            
            // Timer place holder.
            Circle()
                .strokeBorder(lineWidth: 24)
            
            HStack {
                Text("Speaker 1 of 3")
                
                Spacer()
                
                Button {
                    // Action.
                } label: {
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel("Next speaker") // VoiceOver reads "Next speaker. Button."

            }
        }
        .padding()
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
