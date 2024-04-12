//
// TouchIndicatorConfiguration.swift
// TouchIndicators
//
// Created by Alexander Chekel on 12.04.2024.
// Copyright © 2024 Alexander Chekel. All rights reserved.
//

import UIKit

public struct TouchIndicatorConfiguration {
    public enum BorderKind {
        case none
        case solid(_ width: CGFloat, color: UIColor)
    }

    public var size: CGFloat
    public var backgroundColor: UIColor
    public var border: BorderKind
}

public extension TouchIndicatorConfiguration {
    static let `default` = TouchIndicatorConfiguration(
        size: 32,
        backgroundColor: .gray.withAlphaComponent(0.5),
        border: .solid(2, color: .gray)
    )
}
