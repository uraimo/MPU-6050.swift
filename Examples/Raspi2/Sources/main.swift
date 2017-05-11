import SwiftyGPIO
import MPU-6050
import Foundation

let i2cs = SwiftyGPIO.hardwareI2Cs(for:.RaspberryPi2)!
let i2c = i2cs[0]

let mp = MPU-6050(i2c)

mp.enable(true)

while(true){
    let (ax,ay,az,t,gx,gy,gz) = mp.getAll()
    print("Accelerometer - x:\(ax),y:\(ay),z:\(az)")
    print("Gyroscope - x:\(gx),y:\(gy),z:\(gz)")
    print("Temperature(°c): \(t)")
    sleep(1)
}
