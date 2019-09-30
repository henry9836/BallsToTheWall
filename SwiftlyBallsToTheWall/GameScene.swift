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

    
    
    var gameBall: SKSpriteNode!
    var wheel: SKSpriteNode!
    
    var score: SKLabelNode!
    var currentScore: Int = 0
    var fallSpeed: Double = 10.0
    var fadeLock: Bool = false
    var inLock: Bool = false
    var colorMatched: Bool = false
    var gameOver: Bool = false
    
    //0 - red, 1 - yellow, 2 - green, 3 - blue
    var rotTrack: Int = 0
    var colorTrack: Int = 0
    
    let speedIncrease: Double = 0.9
    
    let rotateRightAction = SKAction.rotate(byAngle: CGFloat((Float.pi * 90)/180), duration: 0.3)
    let rotateLeftAction = SKAction.rotate(byAngle: CGFloat((Float.pi * -90)/180), duration: 0.3)
    
    let turnRed = SKAction.colorize(with: UIColor.red, colorBlendFactor: CGFloat(1), duration: 0.3)
    let turnYellow = SKAction.colorize(with: UIColor.yellow, colorBlendFactor: CGFloat(1), duration: 0.3)
    let turnBlue = SKAction.colorize(with: UIColor.blue, colorBlendFactor: CGFloat(1), duration: 0.3)
    let turnGreen = SKAction.colorize(with: UIColor.green, colorBlendFactor: CGFloat(1), duration: 0.3)
    let ballFadeOut = SKAction.fadeAlpha(by: -1.0, duration: 0.3)
    let ballFadeIn = SKAction.fadeAlpha(by: 1.0, duration: 0.3)
    
    
    override func didMove(to view: SKView){
        createText()
        createSprites()
        
        gameStart()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (gameOver){
            let newScene = MainMenuScene(size: (self.view?.bounds.size)!)
            let transition = SKTransition.reveal(with: .up, duration: 2)
            self.view?.presentScene(newScene, transition: transition)
            transition.pausesOutgoingScene = true
        }
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
        
        if (gameBall.position.y == (self.frame.minY + 150)){
            if (!fadeLock){
                fadeLock = true
                gameBall.run(ballFadeOut)
                pickBallColor()
                fallSpeed = fallSpeed * speedIncrease
            }
            if (!gameBall.hasActions()){
                if (colorMatched){
                    gameBall.position.y = self.frame.maxY - 200
                }
            }
        }
        else if (gameBall.position.y < 250){
            if (!inLock){
                if (rotTrack == colorTrack){
                    colorMatched = true
                    currentScore = currentScore + 1
                    score.text = String(currentScore)
                }
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
        else{
            inLock = false
            if (fadeLock){
                gameBall.run(ballFadeIn)
                gameBall.run(SKAction.moveTo(y: CGFloat(self.frame.minY + 150), duration: fallSpeed))
                fadeLock = false
            }
        }
    }
    
    func trackRotation(dir: Int){
        rotTrack = rotTrack + dir
        if (rotTrack < 0){
            rotTrack = 3
        }
        else if (rotTrack > 3){
            rotTrack = 0
        }
    }
    
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
    
    func gameStart(){
        gameBall.run(SKAction.moveTo(y: CGFloat(self.frame.minY + 150), duration: fallSpeed))
        pickBallColor()
        score.numberOfLines = 0
    }
    
    func createSprites(){
        wheel = SKSpriteNode(texture: SKTexture(imageNamed: "circle"), size: CGSize(width: 250, height: 250))
        wheel.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 150)
        self.addChild(wheel)
        
        gameBall = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), size: CGSize(width: 50, height: 50))
        gameBall.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 200)
        self.addChild(gameBall)
    }
    
    func createText(){
        score = SKLabelNode()
        score.text = "0"
        score.fontSize = 32.0
        //mainMenuTitle.fontName = "AvenirNext-Bold"
        score.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        score.fontColor = UIColor.white
        self.addChild(score)
    }
    
}
