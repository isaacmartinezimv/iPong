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
        
        
        //Asign the variables into the game
        playerScoreLabel = self.childNode(withName: "playerScoreLabel") as! SKLabelNode
        enemyScoreLabel = self.childNode(withName: "enemyScoreLabel") as! SKLabelNode
        
        myEnemy = self.childNode(withName: "spriteEnemy") as! SKSpriteNode
        myEnemy.position.y = (self.frame.height / 2) - 50
        
        myPlayer = self.childNode(withName: "spritePlayer") as! SKSpriteNode
        myPlayer.position.y = (-self.frame.height / 2) + 50
        
        myBall = self.childNode(withName: "spriteBall") as! SKSpriteNode
        
        //create the border arround the scene
        let myBorder = SKPhysicsBody(edgeLoopFrom: self.frame)
        myBorder.friction = 0
        myBorder.restitution = 1
        
        self.physicsBody = myBorder
        startGame()

    }
    
    func startGame() {
        score = [0,0]
        updateScoreInLabels()
        myBall.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        
        //reset the position and impulse of ball after each point
        myBall.position = CGPoint(x: 0, y: 0)
        myBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == myPlayer {
          score[1] += 1
            myBall.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))

        } else if playerWhoWon == myEnemy{
            score[0] += 1
            myBall.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))

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
        switch currentGameType {
        case .easy:
            myEnemy.run(SKAction.moveTo(x: myBall.position.x, duration: 1.0))
            break
        case .medium:
            myEnemy.run(SKAction.moveTo(x: myBall.position.x, duration: 0.7))
            break
        case .hard:
            myEnemy.run(SKAction.moveTo(x: myBall.position.x, duration: 0.5))
            break
        case .player2:
            break
        }

        //testing positions for applying points
        if myBall.position.y <= myPlayer.position.y - 30 {
            addScore(playerWhoWon: myEnemy)
            
        } else if myBall.position.y >= myEnemy.position.y + 30 {
            addScore(playerWhoWon: myPlayer)
        }
    }
    
    func recognizeMovementForPlayerBar(_ touches: Set<UITouch>){
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    myEnemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    
                }
                if location.y < 0 {
                    myPlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
                }
            } else {
                myPlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
            }
        }
    }
    
    func updateScoreInLabels(){
        playerScoreLabel.text = "\(score[1])"
        enemyScoreLabel.text = "\(score[0])"
    }
}
