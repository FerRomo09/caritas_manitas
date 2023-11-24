/*
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    var crashDetectionManager: CrashDetectionManager?
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        crashDetectionManager = CrashDetectionManager()
        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Stop the background task when the app comes back to the foreground
        if backgroundTask != .invalid {
            application.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }

        // Resume motion updates
        crashDetectionManager?.startMotionUpdates()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Start a background task to ensure continuous execution
        backgroundTask = application.beginBackgroundTask {
            // Cleanup code if the task is interrupted
            application.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = .invalid
        }

        // Ensure the crash detection manager continues to run in the background
        crashDetectionManager?.startMotionUpdates()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Stop motion updates when the app is terminated
        crashDetectionManager?.stopMotionUpdates()
    }
}

*/
