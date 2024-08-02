//
//  PresentDetailEditView.swift
//  Scrumdinger
//
//  Created by Rafael Badaró on 15/07/24.
//

import SwiftUI

struct PresentDetailEditView: View {
    @Binding var isPresentingEditView: Bool
    @Binding var scrum: DailyScrum
    @State private var editingScrum: DailyScrum
    
    // Note: this is only present because I wanted to initialize 'editingScrum'
    // with the values from 'scrum' so I can update the scrum Binding on line 37
    
    init(isPresentingEditView: Binding<Bool>, scrum: Binding<DailyScrum>) {
        self._isPresentingEditView = isPresentingEditView
        self._scrum = scrum
        self._editingScrum = State(initialValue: scrum.wrappedValue)
    }
    
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $editingScrum)
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
                            scrum = editingScrum
                        }
                    }
                }
        }
    }
}

#Preview {
    PresentDetailEditView(
        isPresentingEditView: .constant(true),
        scrum: .constant(DailyScrum.sampleData[0]))
}
