//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by Rafael Badaró on 18/07/24.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ErrorView(errorWrapper: wrapper)
}

enum SampleError: Error {
    case errorRequired
}

var wrapper: ErrorWrapper {
    ErrorWrapper(error: SampleError.errorRequired,
                 guidance: "You can safely ignore this error.")
}
