//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2023-01-03.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss // View's dismiss structure to be called to dismiss the view (dismiss()).
    
    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "exclamationmark.triangle.fill")
                .renderingMode(.original)
                .font(.system(size: 64))
                .padding(.top, 36)
            
            Text("An Error Has Occured")
                .font(.title)
                .bold()
            
            Text(errorWrapper.error.localizedDescription)
                .multilineTextAlignment(.center)
            
            Text(errorWrapper.guidance)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text("OK")
                    .frame(maxWidth: .infinity, minHeight: 32)
                    .bold()
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(12)
        }
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case errorRequired
    }
    
    static var wrapper: ErrorWrapper {
        ErrorWrapper(
            error: SampleError.errorRequired,
            guidance: "You can safely ignore this error."
        )
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
