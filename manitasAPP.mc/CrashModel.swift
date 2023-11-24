import CoreMotion
import UIKit
import AVFoundation

class CrashDetectionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    private var audioPlayer: AVAudioPlayer?

    @Published var isCrashDetected: Bool = false

    init() {
        startMotionUpdates()
    }

    deinit {
        stopMotionUpdates()
    }

    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                guard let data = data, error == nil else { return }
                self?.processMotionData(data)
            }
        }
    }

    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }

    private func processMotionData(_ data: CMDeviceMotion) {
        isCrashDetected = checkForCrash(data)
        if isCrashDetected {
            handleCrash()
        }
    }

    private func checkForCrash(_ data: CMDeviceMotion) -> Bool {
        // Detect a crash if the acceleration exceeds a certain threshold
        let accelerationThreshold: Double = 4.0
        let spinningThreshold: Double = 2.0  // radians per second

        let acceleration = sqrt(pow(data.userAcceleration.x, 2) + pow(data.userAcceleration.y, 2) + pow(data.userAcceleration.z, 2))
        print("acc=")
        print(acceleration)
        print("spin=")
        print(abs(data.rotationRate.z))        // Check for both acceleration and spinning
        let isAccelerationExceeded = acceleration > accelerationThreshold
        let isSpinning = abs(data.rotationRate.z) > spinningThreshold

        return isAccelerationExceeded && isSpinning
    }

    private func handleCrash() {
        makeEmergencyCall()
        print("-------------------------------------------------------------------------------------------------")
    }

    private func makeEmergencyCall() {
        guard let url = URL(string: "tel://3317589454") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
