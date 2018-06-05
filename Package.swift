import PackageDescription

let package = Package(
    name: "MPU6050",
    dependencies: [
        .Package(url: "https://github.com/uraimo/SwiftyGPIO.git",
                 majorVersion: 1)
    ]
)
