//
//  MeetingViewFooter.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2023-01-01.
//

import SwiftUI

struct MeetingViewFooter: View {
    let speakers: [ScrumTimer.Speaker]
    
    var skipAction: () -> Void
    private var speakerNumber: Int? {
        // Active speaker is first attendee where isCompleted is false.
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1
    }
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy { $0.isCompleted } // True if each speaker's isCompleted is true except for last speaker.
    }
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "No more speakers" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker") // VoiceOver reads "Next speaker. Button."
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingViewFooter_Previews: PreviewProvider {
    static var previews: some View {
        MeetingViewFooter(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
