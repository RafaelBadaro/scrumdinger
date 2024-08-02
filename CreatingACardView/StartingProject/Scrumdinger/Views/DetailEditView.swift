//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Rafael Badaró on 10/07/24.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var editingScrum: DailyScrum
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $editingScrum.title)
                HStack {
                    Slider(value: $editingScrum.lengthInMinutesAsDouble, in: 5...30, step: 1) {
                        Text("Length") // accessibility text
                    }
                    .accessibilityValue("\(editingScrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(editingScrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $editingScrum.theme)
            }
            Section(header: Text("Attendees")){
                ForEach(editingScrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    editingScrum.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            editingScrum.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

#Preview {
    DetailEditView(editingScrum: .constant(DailyScrum.sampleData[0]))
}
