//
// UIWindow+SwiftUI.swift
// TouchIndicators
//
// Created by Alexander Chekel on 12.04.2024.
// Copyright © 2024 Alexander Chekel. All rights reserved.
//

#if canImport(SwiftUI)

import SwiftUI
import UIKit

public extension UIWindow {
    @available(iOS 13, *)
    static var showsTouchesBinding: Binding = .init(
        get: { UIWindow.showsTouches },
        set: { UIWindow.showsTouches = $0 }
    )
}

#endif
