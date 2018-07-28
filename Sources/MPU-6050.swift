/*
   MPU-6050.swift

   Copyright (c) 2017 Umberto Raimondi
   Licensed under the MIT license, as follows:

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.)
*/

import SwiftyGPIO  //Comment this when not using the package manager


public class MPU6050{
    var i2c: I2CInterface
    let address: Int

    public init(_ i2c: I2CInterface, address: Int = 0x68) {
       self.i2c = i2c
       self.address = address
    }

    public var AccelX: Int {
        var rv = UInt16(i2c.readByte(address, command: 0x3B)) << 8
        rv |= UInt16(i2c.readByte(address, command: 0x3C))  
        if (rv >= 0x8000) {
            return -(Int((UInt16.max - rv) + 1))
        } else {
            return Int(rv)
        }
    }

    public var AccelY: Int {
        var rv = UInt16(i2c.readByte(address, command: 0x3D)) << 8
        rv |= UInt16(i2c.readByte(address, command: 0x3E))  
        if (rv >= 0x8000) {
            return -(Int((UInt16.max - rv) + 1))
        } else {
            return Int(rv)
        }
    }

    public var AccelZ: Int {
        var rv = UInt16(i2c.readByte(address, command: 0x3F)) << 8
        rv |= UInt16(i2c.readByte(address, command: 0x40))     
        if (rv >= 0x8000) {
            return -(Int((UInt16.max - rv) + 1))
        } else {
            return Int(rv)
        }
    }

    /// Temperature from -40 to +85 degrees Celsius
    public var Temp: Float {
        var rv = UInt16(i2c.readByte(address, command: 0x41)) << 8
        rv |= UInt16(i2c.readByte(address, command: 0x42))     
        return Float(Int16(bitPattern:rv)) / 340 + 36.53
    }

    /// Enables or disables the device
    public func enable(_ on: Bool){
        // PWR_MGMT_1 register, SLEEP bit
        i2c.writeByte(address, command: 0x6B, value: UInt8(on ? 0 : 0x40))
    }

    /// Resets the device
    public func reset(){
        // PWR_MGMT_1 register, SLEEP bit
        let tmp = i2c.readByte(address, command: 0x6B) 
        i2c.writeByte(address, command: 0x6B, value: UInt8(0x80))
        i2c.writeByte(address, command: 0x6B, value: tmp)
    }

    public var GyroX: Int {
        var rv = UInt16(i2c.readByte(address, command: 0x43)) << 8
        rv |= UInt16(i2c.readByte(address, command: 0x44))     
        if (rv >= 0x8000) {
            return -(Int((UInt16.max - rv) + 1))
        } else {
            return Int(rv)
        }
    }

    public var GyroY: Int {
        var rv = UInt16(i2c.readByte(address, command: 0x45)) << 8
        rv |= UInt16(i2c.readByte(address, command: 0x46))  
        if (rv >= 0x8000) {
            return -(Int((UInt16.max - rv) + 1))
        } else {
            return Int(rv)
        }
    }

    public var GyroZ: Int {
        var rv = UInt16(i2c.readByte(address, command: 0x47)) << 8
        rv |= UInt16(i2c.readByte(address, command: 0x48))     
        if (rv >= 0x8000) {
            return -(Int((UInt16.max - rv) + 1))
        } else {
            return Int(rv)
        }
    }

    public func getAll() -> (AccelX: Int, AccelY: Int, AccelZ: Int, Temp: Float, GyroX: Int, GyroY:Int , GyroZ: Int) {
        return (self.AccelX,self.AccelY,self.AccelZ,self.Temp,self.GyroX,self.GyroY,self.GyroZ)
    }

}
