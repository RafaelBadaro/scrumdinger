/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums){
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error,
                                                    guidance: "Try again later.")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    /*
                     How to test if error screen shows up correctly:
                     1 - Open an terminal window and run: xcrun simctl get_app_container booted com.example.apple-samplecode.Scrumdinger data
                     2 - Get the URL generated from command above and run: open -a Finder <paste path to your App Sandbox>
                     3 - Open the Documents folder and open the scrums.data file (control click  -> Open With -> Text Edit)
                     4 - Delete the first occurrence of the word "id"
                     5 - Build + run to see the error screen
                     
                     */
                    errorWrapper = ErrorWrapper(error: error,
                                                guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.scrums = DailyScrum.sampleData

            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
