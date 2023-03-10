//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2022-12-29.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    
    // Kept alive for the life cycle of the view.
    @StateObject var scrumTimer = ScrumTimer() // "@StateObject" signifies that the current view owns the source of truth for the object.
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    @State private var isRecording = false
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            
            VStack {
                MeetingViewHeader(
                    secondsElapsed: scrumTimer.secondsElapsed, // No need for binding since data is only read, not written to.
                    secondsRemaining: scrumTimer.secondsRemaining,
                    theme: scrum.theme
                )
                MeetingTimerView(
                    speakers: scrumTimer.speakers,
                    theme: scrum.theme,
                    isRecording: isRecording
                )
                MeetingViewFooter(
                    speakers: scrumTimer.speakers,
                    skipAction: scrumTimer.skipSpeaker
                )
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            // Timer resets when MeetingView instance appears (meeting should begin).
            scrumTimer.reset(
                lengthInMinutes: scrum.lengthInMinutes,
                attendees: scrum.attendees // Passing in scrum's attendees (speakers).
            )
            
            scrumTimer.speakerChangedAction = {
                // Called when speaker's time expires.
                player.seek(to: .zero) // Ensures player plays from beginning.
                player.play() // Play ding sound.
            }
            
            // Begin transcribing.
            speechRecognizer.reset() // Ensure speechRecognizer is clean and ready to begin.
            speechRecognizer.transcribe()
            isRecording = true
            
            // Start new timer for this meeting.
            scrumTimer.startScrum()
        }
        .onDisappear {
            // Timer stops when MeetingView instance disappears (meeting ended).
            scrumTimer.stopScrum()
            
            // Stop transcription.
            speechRecognizer.stopTranscribing()
            isRecording = false
            
            let newHistory = History(
                attendees: scrum.attendees,
                lengthInMinutes: scrumTimer.secondsElapsed / 60,
                transcript: speechRecognizer.transcript
            )
            scrum.history.insert(newHistory, at: 0)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
