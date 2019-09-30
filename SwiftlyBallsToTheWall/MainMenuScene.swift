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
    
    let left = SKSpriteNode()
    let right = SKSpriteNode()
    
    var logo: SKSpriteNode!
    var mainMenuTitle: SKLabelNode!
    
    override func didMove(to view: SKView){
        //self.backgroundColor = UIColor.gray
        createText()
        createShapes()
        
        
        left.color = UIColor.red
        left.size = CGSize(width: 64, height: 64)
        left.position = CGPoint(x: self.frame.width/2 - 64, y: self.frame.height/2)
        addChild(left)
        
        right.color = UIColor.blue
        right.size = CGSize(width: 64, height: 64)
        right.position = CGPoint(x: self.frame.width/2 + 64, y: self.frame.height/2)
        addChild(right)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
        if left.contains(location!){
            let newScene = GameScene(size: (self.view?.bounds.size)!)
            let transition = SKTransition.reveal(with: .up, duration: 2)
            self.view?.presentScene(newScene, transition: transition)
            transition.pausesOutgoingScene = true
            transition.pausesOutgoingScene = false
        }
        else if right.contains(location!){
            let newScene = GameScene(size: (self.view?.bounds.size)!)
            let transition = SKTransition.reveal(with: .up, duration: 2)
            self.view?.presentScene(newScene, transition: transition)
            transition.pausesOutgoingScene = true
            transition.pausesOutgoingScene = true
        }
    }
    
    func createShapes(){
        logo = SKSpriteNode(texture: SKTexture(imageNamed: "logo"), size: CGSize(width: 100, height:100))
        logo.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(logo)
        
    }
    
    func createText(){
        mainMenuTitle = SKLabelNode()
        mainMenuTitle.text = "Balls To The Wall"
        mainMenuTitle.fontSize = 32.0
        //mainMenuTitle.fontName = "AvenirNext-Bold"
        mainMenuTitle.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 100.0)
        mainMenuTitle.fontColor = UIColor.white
        self.addChild(mainMenuTitle)
    }
    
    
    
}
