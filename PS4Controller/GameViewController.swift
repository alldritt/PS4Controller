//
//  GameViewController.swift
//  PS4Controller
//
//  Created by Mark Alldritt on 2020-06-19.
//  Copyright © 2020 Mark Alldritt. All rights reserved.
//

import UIKit
import SpriteKit
import GameController


class GameViewController: UIViewController {

    private var controller: GCController?
    private var gameScene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            gameScene = GameScene(size: view.bounds.size)
            gameScene.scaleMode = .aspectFit;
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.presentScene(gameScene)
            
            GCController.startWirelessControllerDiscovery {
                print("controllers: \(GCController.controllers)")
            }
            NotificationCenter.default.addObserver(forName: Notification.Name.GCControllerDidConnect,
                                                   object: nil,
                                                   queue: nil) { (notification) in
                                                    guard let controller = notification.object as? GCController else { return }
                                                    
                                                    if controller.extendedGamepad != nil {
                                                        self.connectToController(controller)
                                                    }
            }
            NotificationCenter.default.addObserver(forName: Notification.Name.GCControllerDidDisconnect,
                                                   object: nil,
                                                   queue: nil) { (notification) in
                                                    guard let controller = notification.object as? GCController else { return }
                                                    
                                                    if self.controller == controller {
                                                        self.disconnectFromController()
                                                    }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func connectToController(_ controller: GCController) {
        if self.controller != nil {
            disconnectFromController()
        }
        
        self.controller = controller
        self.gameScene.controllerIsActive = true
        
        controller.extendedGamepad?.leftTrigger.valueChangedHandler = { (dpad, value, pressed) in
            print("leftTrigger - value: \(value), pressed: \(pressed)")
            self.gameScene.leftTrigger = value
            self.gameScene.leftTriggerPressed = pressed
        }
        controller.extendedGamepad?.rightTrigger.valueChangedHandler = { (dpad, value, pressed) in
            print("rightTrigger - value: \(value), pressed: \(pressed)")
            self.gameScene.rightTrigger = value
            self.gameScene.rightTriggerPressed = pressed
        }
        controller.extendedGamepad?.leftThumbstick.valueChangedHandler = { (dpad, xValue, yValue) in
            print("leftThumbstick - xValue: \(xValue), yValue: \(yValue)")
            self.gameScene.leftThumbX = xValue
            self.gameScene.leftThumbY = yValue
        }
        controller.extendedGamepad?.rightThumbstick.valueChangedHandler = { (dpad, xValue, yValue) in
            print("rightThumbstick - xValue: \(xValue), yValue: \(yValue)")
            self.gameScene.rightThumbX = xValue
            self.gameScene.rightThumbY = yValue
        }
        controller.extendedGamepad?.leftThumbstickButton?.valueChangedHandler = { (dpad, value, pressed) in
            print("leftThumbstickButton - value: \(value), pressed: \(pressed)")
            self.gameScene.leftThumbPressed = pressed
        }
        controller.extendedGamepad?.rightThumbstickButton?.valueChangedHandler = { (dpad, value, pressed) in
            print("rightThumbstickButton - value: \(value), pressed: \(pressed)")
            self.gameScene.rightThumbPressed = pressed
        }
        controller.extendedGamepad?.leftShoulder.pressedChangedHandler = { (dpad, value, pressed) in
            print("leftShoulder - value: \(value), pressed: \(pressed)")
            self.gameScene.leftSholderPressed = pressed
        }
        controller.extendedGamepad?.rightShoulder.pressedChangedHandler = { (dpad, value, pressed) in
            print("rightShoulder - value: \(value), pressed: \(pressed)")
            self.gameScene.rightSholderPressed = pressed
        }
        controller.extendedGamepad?.buttonOptions?.valueChangedHandler = { (dpad, value, pressed) in
            print("buttonOptions - value: \(value), pressed: \(pressed)")
            self.gameScene.optionsPressed = pressed
        }
        controller.extendedGamepad?.buttonMenu.valueChangedHandler = { (dpad, value, pressed) in
            print("buttonMenu - value: \(value), pressed: \(pressed)")
            self.gameScene.menuPressed = pressed
        }
        controller.extendedGamepad?.dpad.up.valueChangedHandler = { (dpad, value, pressed) in
            print("dpad.up - value: \(value), pressed: \(pressed)")
            self.gameScene.dpadUpPressed = pressed
        }
        controller.extendedGamepad?.dpad.down.valueChangedHandler = { (dpad, value, pressed) in
            print("dpad.down - value: \(value), pressed: \(pressed)")
            self.gameScene.dpadDownPressed = pressed
        }
        controller.extendedGamepad?.dpad.left.valueChangedHandler = { (dpad, value, pressed) in
            print("dpad.left - value: \(value), pressed: \(pressed)")
            self.gameScene.dpadLeftPressed = pressed
        }
        controller.extendedGamepad?.dpad.right.valueChangedHandler = { (dpad, value, pressed) in
            print("dpad.right - value: \(value), pressed: \(pressed)")
            self.gameScene.dpadRightPressed = pressed
        }
        controller.extendedGamepad?.buttonX.valueChangedHandler = { (dpad, value, pressed) in
            print("buttonX - value: \(value), pressed: \(pressed)")
            self.gameScene.xPressed = pressed
        }
        controller.extendedGamepad?.buttonY.valueChangedHandler = { (dpad, value, pressed) in
            print("buttonY - value: \(value), pressed: \(pressed)")
            self.gameScene.yPressed = pressed
        }
        controller.extendedGamepad?.buttonA.valueChangedHandler = { (dpad, value, pressed) in
            print("buttonA - value: \(value), pressed: \(pressed)")
            self.gameScene.aPressed = pressed
        }
        controller.extendedGamepad?.buttonB.valueChangedHandler = { (dpad, value, pressed) in
            print("buttonB - value: \(value), pressed: \(pressed)")
            self.gameScene.bPressed = pressed
        }
    }
    
    private func disconnectFromController() {
        self.controller = nil;
        gameScene.controllerIsActive = false
    }
}
