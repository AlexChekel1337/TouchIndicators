# TouchIndicators
Unlike Android, iOS does not get an option to show touches, sometimes making it harder to understand which buttons users press to get to the problem, [especially with `UICollectionView`-backed Lists and Forms in SwiftUI](https://x.com/leonatan/status/1709161093392703642).  
Here's where **TouchIndicators** comes to the rescue! It is a small Swift package that enables your app to show touch indicators in screen recordings and screenshots, and is compatible with both UIKit and SwiftUI projects.

![Platform badge] ![OS badge] ![Swift badge]

![Example]

## Usage
You can enable or disable touch indicators at any moment by updaing `showsTouches` property on `UIWindow`:
```swift
import SwiftUI
import TouchIndicators
import UIKit

@main
struct MyApp: App {
    var body: some Scene {
        ContentView()
    }

    init() {
        UIWindow.showsTouches = true
    }
}
```

In SwiftUI-based projects you also have a binding to easily connect your toggle to the `showsTouches` property:
```swift
Toggle("Show touches", isOn: UIWindow.showsTouchesBinding)
```

## Appearance
Touch indicator appearance can be configured with custom background color, border, or size. Here's how to customize certain properties or create a fully custom configuration:
```swift
// Update configuration with custom touch indicator size...
UIWindow.touchIndicatorConfiguration.size = 44

// ...or create a fully custom configuration
let configuration = TouchIndicatorConfiguration(
    size: 44,
    backgroundColor: .red.withAlphaComponent(0.5),
    border: .solid(1, .red)
)
UIWindow.touchIndicatorConfiguration = configuration
```

[Platform badge]: https://img.shields.io/badge/Platform-iOS-green
[OS badge]: https://img.shields.io/badge/iOS-12.0+-green
[Swift badge]: https://img.shields.io/badge/Swift-5.9-orange
[Example]: ./Media/example.gif