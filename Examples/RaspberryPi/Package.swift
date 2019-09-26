// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "TestMPU6050",
    dependencies: [
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.0.0"),
        .package(url: "https://github.com/uraimo/MPU-6050.swift.git",from: "2.0.0")
    ],
    targets: [
        .target(name: "TestMPU6050", 
                dependencies: ["SwiftyGPIO","MPU6050"],
                path: "Sources")
    ]
) 