// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "nashy-navigation",
    platforms: [.iOS(.v15)],
    products: [.library(name: "NashyNavigation", targets: ["NashyNavigation"])],
    targets: [.target(name: "NashyNavigation")]
)
