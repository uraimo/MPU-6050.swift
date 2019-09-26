// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "MPU6050",
    products: [
        .library(
            name: "MPU6050",
            targets: ["MPU6050"]),
    ],
    dependencies: [
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "MPU6050",
            dependencies: ["SwiftyGPIO"],
            path: ".",
            sources: ["Sources"])
    ]
)