import SwiftUI

@main
struct manitasAPP_mcApp: App {
    // Initialize the AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    // Initialize the CrashDetectionManager
    @StateObject private var crashDetectionManager = CrashDetectionManager()
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(crashDetectionManager)
        }
    }
}
