//
//  GameScene.swift
//  SwiftlyBallsToTheWall
//
//  Created by Henry Oliver on 30/09/19.
//  Copyright © 2019 Henry Oliver. All rights reserved.
//

import SpriteKit
import GameplayKit

class MainMenuScene: SKScene {
    
    //nodes
    var logo: SKSpriteNode!
    var mainMenuTitle: SKLabelNode!
    var tapToPlay: SKLabelNode!
    var highScoreText: SKLabelNode!
    var lastRoundScore: SKLabelNode!
    
    
    override func didMove(to view: SKView){
        createText() //Create Text Nodes
        createShapes() //Create Shape Nodes
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Transition to game scene
        let newScene = GameScene(size: (self.view?.bounds.size)!)
        let transition = SKTransition.reveal(with: .up, duration: 2)
        self.view?.presentScene(newScene, transition: transition)
        transition.pausesOutgoingScene = true
    }
    
    override func update(_ currentTime: TimeInterval) {
        //make logo spin
        if (!logo.hasActions()){
            logo.run(SKAction.rotate(byAngle: -1/5, duration: 1))
        }
    }
    
    func createShapes(){
        //create logo
        logo = SKSpriteNode(texture: SKTexture(imageNamed: "logo"), size: CGSize(width: 800, height: 800))
        logo.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(logo)
        
    }
    
    func createText(){
        //create title
        mainMenuTitle = SKLabelNode()
        mainMenuTitle.text = "Balls To The Wall"
        mainMenuTitle.fontSize = 32.0
        //mainMenuTitle.fontName = "AvenirNext-Bold"
        mainMenuTitle.position = CGPoint(x: self.frame.midX, y: self.frame.midY+50)
        mainMenuTitle.fontColor = UIColor.white
        self.addChild(mainMenuTitle)
        
        //create instuction
        mainMenuTitle = SKLabelNode()
        mainMenuTitle.text = "Tap To Start"
        mainMenuTitle.fontSize = 15.0
        mainMenuTitle.position = CGPoint(x: self.frame.midX, y: self.frame.midY-50)
        mainMenuTitle.fontColor = UIColor.white
        self.addChild(mainMenuTitle)
        
        //create highscore text
        mainMenuTitle = SKLabelNode()
        mainMenuTitle.text = "HighScore: " + String(UserDefaults.standard.integer(forKey: "highScore")) //retrieve highscore from storage
        mainMenuTitle.fontSize = 25.0
        mainMenuTitle.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        mainMenuTitle.fontColor = UIColor.white
        self.addChild(mainMenuTitle)
        
        //create previous score text
        mainMenuTitle = SKLabelNode()
        mainMenuTitle.text = "Previous Game's Score: " + String(UserDefaults.standard.integer(forKey: "roundScore")) //retrieve score from storage
        mainMenuTitle.fontSize = 13.0
        mainMenuTitle.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 75)
        mainMenuTitle.fontColor = UIColor.white
        self.addChild(mainMenuTitle)
    }

    
    
    
}
