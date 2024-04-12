//
// UIWindow+TouchEvents.swift
// TouchIndicators
//
// Created by Alexander Chekel on 12.04.2024.
// Copyright © 2024 Alexander Chekel. All rights reserved.
//

import UIKit

extension UIWindow {
    /// Enables or disables touch indicators on all instances of `UIWindow`.
    public static var showsTouches: Bool = false {
        didSet {
            swizzleMethodsIfNeeded()
        }
    }

    /// Indicates whether method swizzling has already occurred.
    private static var didSwizzleMethods: Bool = false

    private static func swizzleMethodsIfNeeded() {
        guard !didSwizzleMethods else {
            return
        }

        let originalSelector = #selector(UIWindow.sendEvent(_:))
        let replacementSelector = #selector(UIWindow.swizzled_sendEvent(_:))

        guard
            let originalMethod = class_getInstanceMethod(UIWindow.self, originalSelector),
            let replacementMethod = class_getInstanceMethod(UIWindow.self, replacementSelector)
        else {
            print("[TouchIndicators] ⚠️ Couldn't get required instance methods. Showing touches is unavailable.")
            return
        }

        method_exchangeImplementations(originalMethod, replacementMethod)
        didSwizzleMethods = true
    }

    /// Custom implementation of sendEvent(_:) instance method.
    @objc private dynamic func swizzled_sendEvent(_ event: UIEvent) {
        swizzled_sendEvent(event)
    }
}
