//
//  ViewController.swift
//  2ADCMotorPhidget
//
//  Created by Joel Igberase on 2019-05-24.
//  Copyright © 2019 Joel Igberase. All rights reserved.
//

import UIKit
import Phidget22Swift



class ViewController: UIViewController {
    
    var voltVert = VoltageRatioInput()
    var voltHor = VoltageRatioInput()
    var button = DigitalInput()
    var motor0 = DCMotor()
    var motor1 = DCMotor()
    var acc : Bool = false
    var mot : Int = 0
    
    //var runCount : Float = 0
   // var runTimer : Bool = true
   // weak var timer: Timer?
    
    func attach_handler(sender: Phidget) {
        do {
            let hubPort = try sender.getHubPort()
            let channel = try sender.getChannel()
            if hubPort == 0 {
                if channel == 0 {
                    print("Vertical Axis attached")
                } else if channel == 1 {
                    print("Horizontal Axis attached")
                }
                print("Thumbstick attached")
            } else if hubPort == 1 {
                print("Motor 0 attached")
                try motor0.setTargetVelocity(0.5)
            } else if hubPort == 2 {
                print("Motor 1 attached")
                try motor1.setTargetVelocity(0.5)
            } else if hubPort == 3 {
                print("Sonar attached")
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch {
            //catch other errors here
        }
        
    }

    func voltageRatioChange(sender: VoltageRatioInput, voltageRatio: Double){
        do {
            print(try motor1.getVelocity())
           // try motor0.setTargetVelocity(voltVert.getVoltageRatio())
           // try motor1.setTargetVelocity(voltVert.getVoltageRatio())
            if try voltVert.getVoltageRatio() >= 0 && voltHor.getVoltageRatio() >= 0 {
                if try voltHor.getVoltageRatio() == 0 {
                //    try motor1.setAcceleration(0.0)
                    acc = false
                } else {
                 //   try motor1.setAcceleration(5.1)
                  //  try motor0.setAcceleration(0.0)
                    acc = true
                }
                mot = 1

            } else if try voltVert.getVoltageRatio() >= 0 && voltHor.getVoltageRatio() <= 0 {
                if try voltHor.getVoltageRatio() == 0 {
                    //try motor0.setAcceleration(0.0)
                    acc = false
                } else {
                   // try motor0.setAcceleration(5.1)
                    //try motor1.setAcceleration(0.0)
                    acc = true
                }
              //  mot = 0

            } else if try voltVert.getVoltageRatio() <= 0 && voltHor.getVoltageRatio() <= 0 {
                if try voltHor.getVoltageRatio() == 0 {
                  //  try motor0.setAcceleration(0.0)
                    acc = false
                } else{
                  //  try motor0.setAcceleration(5.1)
                  //  try motor1.setAcceleration(0.0)
                    acc = true
                }
                mot = 0
            }  else if try voltVert.getVoltageRatio() <= 0 && voltHor.getVoltageRatio() >= 0 {
                if try voltHor.getVoltageRatio() == 0 {
                   // try motor1.setAcceleration(0.0)
                    acc = false
                } else {
                   // try motor1.setAcceleration(5.1)
                   // try motor0.setAcceleration(0.0)
                    acc = true
                }
                mot = 1
            }

            
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch {
            //catch other errors here
        }
        
    }
    
//    func volta(sender: VoltageRatioInput, voltageRatio: Double) -> Double{
//        do {
//            return (try voltVert.getVoltageRatio(), try voltHor.getVoltageRatio())
//        } catch let err as PhidgetError{
//            print("Phidget Error " + err.description)
//        } catch {
//            //catch other errors here
//        }
//    }
    
//    func vel(sender: DCMotor, velocity: Double) {
//        do {
//            try motor0.setTargetVelocity(volta[0])
//            try motor1.setTargetVelocity(voltVert.getVoltageRatio())
//            if try voltVert.getVoltageRatio() >= 0 && voltHor.getVoltageRatio() >= 0 {
//                if try voltHor.getVoltageRatio() == 0 {
//                    // try motor1.setAcceleration(0.0)
//                } else {
//                    //try motor1.setAcceleration(5.1)
//                    //try motor0.setAcceleration(0.0)
//                }
//            } else if try voltVert.getVoltageRatio() >= 0 && voltHor.getVoltageRatio() <= 0 {
//                if try voltHor.getVoltageRatio() == 0 {
//                    //try motor0.setAcceleration(0.0)
//                } else {
//                    //try motor0.setAcceleration(5.1)
//                    //try motor1.setAcceleration(0.0)
//                }
//            } else if try voltVert.getVoltageRatio() <= 0 && voltHor.getVoltageRatio() <= 0 {
//                if try voltHor.getVoltageRatio() == 0 {
//                    //try motor0.setAcceleration(0.0)
//                } else{
//                    //try motor0.setAcceleration(5.1)
//                    //try motor1.setAcceleration(0.0)
//                }
//            }  else if try voltVert.getVoltageRatio() <= 0 && voltHor.getVoltageRatio() >= 0 {
//                if try voltHor.getVoltageRatio() == 0 {
//                    //try motor1.setAcceleration(0.0)
//                } else {
//                    //try motor1.setAcceleration(5.1)
//                    //try motor0.setAcceleration(0.0)
//                }
//            }
//
//
//
//
//
//        } catch let err as PhidgetError{
//            print("Phidget Error " + err.description)
//        } catch {
//            //catch other errors here
//        }
//    }
    
    func velocityChange(sender: DCMotor, velocity: Double) {
        do {
            if mot == 0 {
                if acc == true {
                    try motor0.setAcceleration(5.1)
                    try motor1.setAcceleration(0.0)
                } else {
                    try motor0.setAcceleration(0.0)
                }
            } else if mot == 1 {
                if acc == true {
                    try motor1.setAcceleration(5.1)
                    try motor0.setAcceleration(0.0)
                } else {
                    try motor1.setAcceleration(0.0)
                }
            }

        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch {
            //catch other errors here
        }
    }
    func stateChange_handler(sender: DigitalInput, state: Bool){
        do {
            if state == true {
                print(state)
                try motor0.setTargetVelocity(0.0)
                try motor1.setTargetVelocity(0.0)
            }


        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch {
            //catch other errors here
        }

    }


    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            //enable server discovery
            try Net.enableServerDiscovery(serverType: .deviceRemote)
            
            //address objects
            try voltVert.setDeviceSerialNumber(528025)
            try voltVert.setHubPort(0)
            try voltVert.setChannel(0)
            try voltVert.setIsHubPortDevice(false)
            
            try voltHor.setDeviceSerialNumber(528025)
            try voltHor.setHubPort(0)
            try voltHor.setChannel(1)
            try voltHor.setIsHubPortDevice(false)
            
            try button.setDeviceSerialNumber(528025)
            try button.setHubPort(0)
            try button.setIsHubPortDevice(false)
            
            try motor0.setDeviceSerialNumber(528025)
            try motor0.setHubPort(1)
            try motor0.setIsHubPortDevice(false)

            try motor1.setDeviceSerialNumber(528025)
            try motor1.setHubPort(2)
            try motor1.setIsHubPortDevice(false)
            
            //attach handler
            let _ = voltVert.attach.addHandler(attach_handler)
            let _ = voltHor.attach.addHandler(attach_handler)
            let _ = button.attach.addHandler(attach_handler)
            let _ = motor0.attach.addHandler(attach_handler)
            let _ = motor1.attach.addHandler(attach_handler)
            
            //add state change handlers
            let _ = voltVert.voltageRatioChange.addHandler(voltageRatioChange)
            let _ = voltHor.voltageRatioChange.addHandler(voltageRatioChange)
            let _ = motor0.velocityUpdate.addHandler(velocityChange)
            let _ = motor1.velocityUpdate.addHandler(velocityChange)
            let _ = button.stateChange.addHandler(stateChange_handler)
           // let _ = voltVert.voltageRatioChange.addHandler(volta)
           // let _ = voltHor.voltageRatioChange.addHandler(volta)

            
            
            //open objects
            try voltVert.open()
            try voltHor.open()
            try button.open()
            try motor0.open()
            try motor1.open()
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
        
    }
    
    
    
    
    
}


