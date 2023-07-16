// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "LottieSwiftUI",
    platforms: [.iOS(.v13), .macOS(.v11)],
    products: [
        .library(
            name: "LottieSwiftUI",
            targets: ["LottieSwiftUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-spm.git", exact: "4.2.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.6.0"))
    ],
    targets: [
        .target(
            name: "LottieSwiftUI",
            dependencies: [
                .product(name: "Lottie", package: "lottie-spm"),
                "SnapKit",
            ]
        ),
    ]
)
