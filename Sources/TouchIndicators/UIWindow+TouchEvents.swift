//
// UIWindow+TouchEvents.swift
// TouchIndicators
//
// Created by Alexander Chekel on 12.04.2024.
// Copyright © 2024 Alexander Chekel. All rights reserved.
//

import UIKit

extension UIWindow {
    /// Touch indicator appearance configuration.
    public static var touchIndicatorConfiguration: TouchIndicatorConfiguration = .default
    /// Enables or disables touch indicators on all instances of `UIWindow`.
    public static var showsTouches: Bool = false {
        didSet {
            swizzleMethodsIfNeeded()
        }
    }

    private static var didSwizzleMethods: Bool = false
    private static var touchIndicatorLayers: [UITouch: CALayer] = [:]

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

    @objc private dynamic func swizzled_sendEvent(_ event: UIEvent) {
        swizzled_sendEvent(event)

        guard Self.showsTouches, case .touches = event.type, let touches = event.allTouches else {
            return
        }

        for touch in touches {
            let touchLocation = touch.location(in: self)
            let configuration = Self.touchIndicatorConfiguration

            switch touch.phase {
                case .began:
                    let touchIndicatorLayer = CALayer()
                    touchIndicatorLayer.backgroundColor = configuration.backgroundColor.cgColor

                    if case .solid(let width, let color) = configuration.border {
                        touchIndicatorLayer.borderWidth = width
                        touchIndicatorLayer.borderColor = color.cgColor
                    }

                    touchIndicatorLayer.cornerRadius = configuration.size / 2
                    touchIndicatorLayer.frame.size = CGSize(width: configuration.size, height: configuration.size)
                    touchIndicatorLayer.position = touchLocation
                    layer.addSublayer(touchIndicatorLayer)

                    Self.touchIndicatorLayers[touch] = touchIndicatorLayer
                case .moved:
                    CATransaction.begin()
                    CATransaction.setDisableActions(true)
                    Self.touchIndicatorLayers[touch]?.position = touchLocation
                    CATransaction.commit()
                case .ended, .cancelled:
                    Self.touchIndicatorLayers[touch]?.removeFromSuperlayer()
                    Self.touchIndicatorLayers[touch] = nil
                default:
                    break
            }
        }
    }
}
