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
    
    var playerScoreLabel = SKLabelNode()
    var enemyScoreLabel = SKLabelNode()
    
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        startGame()
        
        //Asign the variables into the game
        playerScoreLabel = self.childNode(withName: "playerScoreLabel") as! SKLabelNode
        
        enemyScoreLabel = self.childNode(withName: "enemyScoreLabel") as! SKLabelNode
        
        myBall = self.childNode(withName: "spriteBall") as! SKSpriteNode
        myEnemy = self.childNode(withName: "spriteEnemy") as! SKSpriteNode
        myPlayer = self.childNode(withName: "spritePlayer") as! SKSpriteNode
        
        //Initial impulse
        myBall.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        //create the border arround the scene
        let myBorder = SKPhysicsBody(edgeLoopFrom: self.frame)
        myBorder.friction = 0
        myBorder.restitution = 1
        
        self.physicsBody = myBorder
        
    }
    
    func startGame() {
        score = [0,0]
        updateScoreInLabels()
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        
        //reset the position and impulse of ball after each point
        myBall.position = CGPoint(x: 0, y: 0)
        myBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == myPlayer {
          score[0] += 1
            myBall.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))

        } else if playerWhoWon == myEnemy{
            score[1] += 1
            myBall.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))

        }
        
        updateScoreInLabels()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        recognizeMovementForPlayerBar(touches)
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        recognizeMovementForPlayerBar(touches)
    }

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //Making the enemy move with the ball move but with a little delay
        myEnemy.run(SKAction.moveTo(x: myBall.position.x, duration: 1.0))
        
        //testing positions for applying points
        if myBall.position.y <= myPlayer.position.y - 70 {
            addScore(playerWhoWon: myEnemy)
            
        } else if myBall.position.y >= myEnemy.position.y + 70 {
            addScore(playerWhoWon: myPlayer)
        }
    }
    
    func recognizeMovementForPlayerBar(_ touches: Set<UITouch>){
        for touch in touches {
            let location = touch.location(in: self)
            
            myPlayer.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    func updateScoreInLabels(){
        playerScoreLabel.text = "\(score[1])"
        enemyScoreLabel.text = "\(score[0])"
    }
}
