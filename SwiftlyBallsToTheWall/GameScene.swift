//
//  GameScene.swift
//  SwiftlyBallsToTheWall
//
//  Created by Henry Oliver on 30/09/19.
//  Copyright © 2019 Henry Oliver. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    
    //nodes
    
    var gameBall: SKSpriteNode!
    var wheel: SKSpriteNode!
    
    //game values

    var score: SKLabelNode!
    var currentScore: Int = 0
    var fallSpeed: Double = 10.0
    var fadeLock: Bool = false
    var inLock: Bool = false
    var colorMatched: Bool = false
    var gameOver: Bool = false
    var gameOverLock: Bool = false
    
    //0 - red, 1 - yellow, 2 - green, 3 - blue
    var rotTrack: Int = 0
    var colorTrack: Int = 0
    
    //constants

    let speedIncrease: Double = 0.9
    
    let rotateRightAction = SKAction.rotate(byAngle: CGFloat((Float.pi * 90)/180), duration: 0.3)
    let rotateLeftAction = SKAction.rotate(byAngle: CGFloat((Float.pi * -90)/180), duration: 0.3)
    
    let turnRed = SKAction.colorize(with: UIColor(red: 0.835,green: 0.267, blue: 0.267, alpha: 1.0), colorBlendFactor: CGFloat(1), duration: 0.3)
    let turnYellow = SKAction.colorize(with: UIColor(red: 0.902,green: 1.0, blue: 0.302, alpha: 1.0), colorBlendFactor: CGFloat(1), duration: 0.3)
    let turnGreen = SKAction.colorize(with: UIColor(red: 0.267,green: 0.835, blue: 0.267, alpha: 1.0), colorBlendFactor: CGFloat(1), duration: 0.3)
    let turnBlue = SKAction.colorize(with: UIColor(red: 0.267,green: 0.494, blue: 0.835, alpha: 1.0), colorBlendFactor: CGFloat(1), duration: 0.3)
    let ballFadeOut = SKAction.fadeAlpha(by: -1.0, duration: 0.3)
    let ballFadeIn = SKAction.fadeAlpha(by: 1.0, duration: 0.3)
    
    
    override func didMove(to view: SKView){
        createText() //create text nodes
        createSprites() //create sprite nodes
        
        gameStart() //initalize game values
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //if (gameOver){
        //    let newScene = MainMenuScene(size: (self.view?.bounds.size)!)
        //    let transition = SKTransition.reveal(with: .up, duration: 2)
        //    self.view?.presentScene(newScene, transition: transition)
        //    transition.pausesOutgoingScene = true
        //}
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        if let location =  touches.first?.location(in: self.view){
            if (location.x < self.frame.midX){ //user tapped on left side of screen
                wheel.run(rotateRightAction)
                trackRotation(dir: 1)
            }
            else{ //user tapped on right side of screen
                wheel.run(rotateLeftAction)
                trackRotation(dir: -1)
            }
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if (gameOver){ //when the player has lost the game
            if (!gameOverLock && fadeLock && !gameBall.hasActions()){ //after some time has passed
                //go to the mainmenu scene
                let newScene = MainMenuScene(size: (self.view?.bounds.size)!) 
                let transition = SKTransition.reveal(with: .up, duration: 2)
                self.view?.presentScene(newScene, transition: transition)
                transition.pausesOutgoingScene = true
                gameOverLock = true
            }
        }
        
        //when the ball is inside the center of the ring
        if (gameBall.position.y == (self.frame.minY + 150)){
            if (!fadeLock){
                //make the ball fade out
                fadeLock = true
                gameBall.run(ballFadeOut)
                pickBallColor()
                fallSpeed = fallSpeed * speedIncrease
            }
            if (!gameBall.hasActions()){
                //if we matched the color reset the ball position
                if (colorMatched){
                    gameBall.position.y = self.frame.maxY - 200
                }
            }
        }
        //once we are in the middle of a segment
        else if (gameBall.position.y < 250){
            if (!inLock){
                //if we matched with the correct color
                if (rotTrack == colorTrack){
                    colorMatched = true
                    currentScore = currentScore + 1
                    score.text = String(currentScore)
                }
                //if we did not match with the correct color gameover
                else{
                    UserDefaults.standard.set(currentScore, forKey: "roundScore")
                    score.text = "Gameover\nScore: " + String(currentScore)
                    if (UserDefaults.standard.integer(forKey: "highScore") < currentScore){
                        UserDefaults.standard.set(currentScore, forKey: "highScore")
                        score.text = "Gameover\nNew HighScore!\nScore: " + String(currentScore)
                    }
                    gameOver = true
                    colorMatched = false
                }
                inLock = true
                
            }
        }
        //move the ball down
        else{
            inLock = false
            if (fadeLock){
                gameBall.run(ballFadeIn)
                gameBall.run(SKAction.moveTo(y: CGFloat(self.frame.minY + 150), duration: fallSpeed))
                fadeLock = false
            }
        }
    }
    
    //tracks the rotation of the ring so that we can tell which color is up
    func trackRotation(dir: Int){
        rotTrack = rotTrack + dir
        if (rotTrack < 0){
            rotTrack = 3
        }
        else if (rotTrack > 3){
            rotTrack = 0
        }
    }
    
    //Pick a random color for the ball
    func pickBallColor(){
        let number = Int.random(in: 0 ... 3)
        if (number == 0){
            gameBall.run(turnRed)
        }
        else if (number == 1){
            gameBall.run(turnYellow)
        }
        else if (number == 2){
            gameBall.run(turnGreen)
        }
        else{
            gameBall.run(turnBlue)
        }
        colorTrack = number
    }
    
    //Initalize the game
    func gameStart(){
        gameBall.run(SKAction.moveTo(y: CGFloat(self.frame.minY + 150), duration: fallSpeed))
        pickBallColor()
        score.numberOfLines = 0 //allow the text to have multiple lines
     }
    
    //create sprite nodes
    func createSprites(){
        //create the ring
        wheel = SKSpriteNode(texture: SKTexture(imageNamed: "circle"), size: CGSize(width: 250, height: 250))
        wheel.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 150)
        self.addChild(wheel)
        
        //create the ball
        gameBall = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), size: CGSize(width: 50, height: 50))
        gameBall.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 200)
        self.addChild(gameBall)
    }
    
    //create text nodes
    func createText(){
        //create the score text
        score = SKLabelNode()
        score.text = "0"
        score.fontSize = 32.0
        //mainMenuTitle.fontName = "AvenirNext-Bold"
        score.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        score.fontColor = UIColor.white
        self.addChild(score)
    }
    
}
