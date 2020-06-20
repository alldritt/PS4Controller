//
//  GameScene.swift
//  PS4Controller
//
//  Created by Mark Alldritt on 2020-06-19.
//  Copyright © 2020 Mark Alldritt. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var controllerIsActive: Bool = false {
        didSet {
            refreshController()
        }
    }
    var dpadUpPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var dpadDownPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var dpadLeftPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var dpadRightPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var xPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var yPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var aPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var bPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var optionsPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var menuPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var leftSholderPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var leftTrigger: Float = 0 {
        didSet {
            refreshController()
        }
    }
    var leftTriggerPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var rightSholderPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var rightTrigger: Float = 0 {
        didSet {
            refreshController()
        }
    }
    var rightTriggerPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var leftThumbPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var leftThumbX: Float = 0 {
        didSet {
            refreshController()
        }
    }
    var leftThumbY: Float = 0 {
        didSet {
            refreshController()
        }
    }
    var rightThumbPressed: Bool = false {
        didSet {
            refreshController()
        }
    }
    var rightThumbX: Float = 0 {
        didSet {
            refreshController()
        }
    }
    var rightThumbY: Float = 0 {
        didSet {
            refreshController()
        }
    }

    private var controllerNode : SKSpriteNode?
    private var needsRefresh = true
    
    private func refreshController() {
        needsRefresh = true
    }
    
    override func sceneDidLoad() {
        backgroundColor = .white
        refreshController()
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard needsRefresh else { return }
        
        //  This is a pretty crude way of drawing the controller, but I had a PS4 controller SVG file from
        //  https://www.svgrepo.com/svg/132200/ps4-wireless-game-control which I adpated using PaintCode into
        //  swift drawing code.  Simple and effective.

        if let oldControllerNode = self.controllerNode {
            removeChildren(in: [oldControllerNode])
        }

        //  Note 1: Thumb and trigger values are -1.0..1.0 but our drawing code expects 0..1
        //  Note 2: We do not draw/show the left/right trigger button & values
        
        let controllerImage = PS3StyleKit.imageOfPs4Controller(active: controllerIsActive,
                                                               menuPressed: menuPressed,
                                                               optionsPressed: optionsPressed,
                                                               leftSholderPressed: leftSholderPressed,
                                                               rightSholderPressed: rightSholderPressed,
                                                               xPressed: xPressed,
                                                               yPressed: yPressed,
                                                               aPressed: aPressed,
                                                               bPressed: bPressed,
                                                               upPressed: dpadUpPressed,
                                                               downPressed: dpadDownPressed,
                                                               leftPressed: dpadLeftPressed,
                                                               rightPressed: dpadRightPressed,
                                                               j1Pressed: leftThumbPressed,
                                                               j1H: CGFloat((leftThumbX + 1) * 0.5),
                                                               j1V: CGFloat((-leftThumbY + 1) * 0.5),
                                                               j2Pressed: rightThumbPressed,
                                                               j2H: CGFloat((rightThumbX + 1) * 0.5),
                                                               j2V: CGFloat((-rightThumbY + 1) * 0.5))
        let controllerTexture = SKTexture(image: controllerImage)
        let controllerNode = SKSpriteNode(texture: controllerTexture, size: controllerImage.size)
        controllerNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(controllerNode)
        self.controllerNode = controllerNode
    }
}
