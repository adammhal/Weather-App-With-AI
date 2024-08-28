//
//  View Extension.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/2/24.
//

import SwiftUI

extension UIDevice {
    static let deviceDidShake = Notification.Name(rawValue: "deviceDidShake")
}

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with: UIEvent?) {
        guard motion == .motionShake else { return }
        
        NotificationCenter.default.post(name: UIDevice.deviceDidShake, object: nil)
    }
}

struct ShakeGestureViewModifier: ViewModifier {
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShake), perform: { _ in
                action()
            })
    }
}

struct invertIfNightViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .colorInvert()
    }
}


extension View {
    public func onShakeGesture(perform action: @escaping () -> Void) -> some View{
        self.modifier(ShakeGestureViewModifier(action: action))
    }
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
