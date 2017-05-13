# MPU-6050.swift

*A Swift library for the MPU-6050 Accelerometer and Gyroscope*

<p>
<img src="https://img.shields.io/badge/os-linux-green.svg?style=flat" alt="Linux-only" />
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift3-compatible-4BC51D.svg?style=flat" alt="Swift 3 compatible" /></a>
<a href="https://raw.githubusercontent.com/uraimo/MPU-6050.swift/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
</p>
 
![MPU-6050](https://github.com/uraimo/MPU-6050.swift/raw/master/mpu-6050.jpg)

# Summary

This is a library for MPU-6050 accelerometer and gyroscope based boards (a few different models are available from Adafruit, Sparkfun or other manufacturers).

You'll be able to read via I2C the current accelerometer values along the X,Y,Z axis, read the current orientation of the gyroscope, check the value of the internal temperature sensor and turn on/off and reset the device.

## Hardware Details

These boards are normally powered with 3.3V and have an `ADD` pin that allows to select an alternative I2C address (put it HIGH for 0x69 instead of the default 0x68) for when you are using more that one of these devices on the same bus. Most of the times you'll connect this pin to `GND`.

They also have an `INT` interrupt output pin that you can ignore and two additional `XDA` and `XCL` (or ASDA and ASCL on some boards) I2C pins to communicate with auxiliary devices controlled by the small internal processor (that has its own firmware but there is no documentation on how to alter it) of the MPU.

Some boards could have additional pins, the only thing you need for this library is the I2C interface, connect it to your ARM board and you are good to go.
 

## Usage

All the accelerometer and gyroscope values are exposed as properties of the main `MPU6050` class but can be also retrieved with a single call with `getAll()` that returns a tuple with all the values.

As for other libraries, to initialize this object you need to retrieve first an `I2CInterface` instance from SwiftyGPIO and then enable the device:

```swift
let i2cs = SwiftyGPIO.hardwareI2Cs(for:.RaspberryPi2)!
let i2c = i2cs[1]

let mp = MPU6050(i2c)

mp.enable(true)

while(true){
    let (ax,ay,az,t,gx,gy,gz) = mp.getAll()
    print("Accelerometer - x:\(ax),y:\(ay),z:\(az)")
    print("Gyroscope - x:\(gx),y:\(gy),z:\(gz)")
    print("Temperature(°c): \(t)")
    sleep(1)
}
```

While you'll normally need all the values at the same time, you can retrieve them as single values using these properties:

```
  public var AccelX: Int
  public var AccelY: Int 
  public var AccelZ: Int
  public var Temp: Float
  public var GyroX: Int
  public var GyroY: Int
  public var GyroZ: Int
```

All the `Int` values are unsigned 16 bit integers.

The device also have self-check functionalities that verify that the internal micro mechanisms o this MEMS chip are working as expected, but those additional functions are not implemented at the moment.

Even if your device is on a flat surface and stationary, you should always expect small variations of the accelerometer and gyroscope values. 
 
## Supported Boards

Every board supported by [SwiftyGPIO](https://github.com/uraimo/SwiftyGPIO): RaspberryPis, BeagleBones, C.H.I.P., etc...

To use this library, you'll need a Linux ARM board with Swift 3.x.

The example below will use a RaspberryPi 2 board but you can easily modify the example to use one the other supported boards, a full working demo projects for the RaspberryPi2 is available in the `Examples` directory.


## Installation

Please refer to the [SwiftyGPIO](https://github.com/uraimo/SwiftyGPIO) readme for Swift installation instructions.

Once your board runs Swift, if your version support the Swift Package Manager, you can simply add this library as a dependency of your project and compile with `swift build`:

```swift
  let package = Package(
      name: "MyProject",
      dependencies: [
        .Package(url: "https://github.com/uraimo/MPU-6050.swift.git", majorVersion: 1),
      ]
  ) 
```

The directory `Examples` contains sample projects that uses SPM, compile it and run the sample with `./.build/debug/TestMPU6050`.

If SPM is not supported, you'll need to manually download the library and its dependencies: 

    wget https://raw.githubusercontent.com/uraimo/DS1307.swift/master/Sources/DS1307.swift https://raw.githubusercontent.com/uraimo/SwiftyGPIO/master/Sources/SwiftyGPIO.swift https://raw.githubusercontent.com/uraimo/SwiftyGPIO/master/Sources/Presets.swift https://raw.githubusercontent.com/uraimo/SwiftyGPIO/master/Sources/I2C.swift https://raw.githubusercontent.com/uraimo/SwiftyGPIO/master/Sources/SunXi.swift  

And once all the files have been downloaded, create an additional file that will contain the code of your application (e.g. main.swift). When your code is ready, compile it with:

    swiftc *.swift

The compiler will create a **main** executable.

