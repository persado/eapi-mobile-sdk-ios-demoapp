//
//  PersadoManager.swift
//  persado-sdk-example
//

import Foundation
import mobilesdk
import AppTrackingTransparency

class PersadoManager {
    static let shared = PersadoManager()
    
    var userAttributes: [String: String] = [:]

    func initializeSdk() {
        requestTracking()
        PSDClient
            .Builder(appId: AppConstants.persadoAppId)
            .userAttributes(value: userAttributes)
            .build()
            .initialize { success, errorMessage in
                if success.boolValue {
                    print("Initialization Succeeded")
                } else {
                    print("Initialization failed. Error message: \(errorMessage ?? "")")
                }
            }
    }

    private func requestTracking() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown and we are authorized
                    print("Tracking Authorized")
                case .denied:
                    // Tracking authorization dialog was shown and permission is denied
                    print("Tracking Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("Tracking Not Determined")
                case .restricted:
                    // Tracking is restricted
                    print("Tracking Restricted")
                @unknown default:
                    print("Tracking Unknown")
                }
            }
        }
    }

    func getCartContent() -> DynamicCartContent? {
        return getContent(for: AppConstants.touchPointName)
    }

    func trackCartView() {
        // View tracking with asynchronous callback
        track(action: .view)
    }

    func trackCompleteClick() {
        // Click tracking
        track(action: .click)
    }

    func trackConversion() {
        // Conversion tracking
        track(action: .convert)
    }

    private func track(action: TrackAction) {
        PSDTrack()
            .userAttributes(value: userAttributes)
            .trackByCampaignLabel(
                action: action,
                campaignLabel: AppConstants.persadoCampaignLabel) { [weak self] success, errorMessage in
                    self?.handleTrackingResult(
                        action: action.name,
                        success: success,
                        errorMessage: errorMessage
                    )
                }
    }

    private func handleTrackingResult(action: String, success: KotlinBoolean, errorMessage: String?) {
        if success.boolValue {
            print("Tracking Succeeded")
        } else {
            print("Tracking failed. Error message: \(errorMessage ?? "")")
        }
    }

    private func getContent<T: Decodable>(for touchPointName: String) -> T? {
        let touchPointContent = PSDContent()
            .getTouchpointContentByLabel(
                campaignLabel: AppConstants.persadoCampaignLabel,
                touchpointName: touchPointName
            )?
            .content
        guard let touchPointContentData = touchPointContent?.data(using: .utf8) else {
            return nil
        }
        do {
            let content = try JSONDecoder().decode(T.self, from: touchPointContentData)
            print(content)
            return content
        } catch {
            print("Decoding of touchpoint data failed with error", error)
            return nil
        }
    }
}
