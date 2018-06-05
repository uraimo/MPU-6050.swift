import PackageDescription

let package = Package(
    name: "TestMPU6050",
    dependencies: [
        .Package(url: "https://github.com/uraimo/MPU-6050.swift.git",
                 majorVersion: 2)
    ]
)
