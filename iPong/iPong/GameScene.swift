//
//  GameScene.swift
//  iPong
//
//  Created by Isaac Martínez on 11/05/2019.
//  Copyright © 2019 Isaac.martinez@basetis.com. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var myBall = SKSpriteNode()
    var myEnemy = SKSpriteNode()
    var myPlayer = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        myBall = self.childNode(withName: "spriteBall") as! SKSpriteNode
        myEnemy = self.childNode(withName: "spriteEnemy") as! SKSpriteNode
        myPlayer = self.childNode(withName: "spritePlayer") as! SKSpriteNode
        
        //Initial impulse
        myBall.physicsBody?.applyImpulse(CGVector(dx: -30, dy: -30))
        
        //create the border arround the scene
        let myBorder = SKPhysicsBody(edgeLoopFrom: self.frame)
        myBorder.friction = 0
        myBorder.restitution = 1
        
        self.physicsBody = myBorder
        
        
    }

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
