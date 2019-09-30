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

    
    
    let firstNode = SKNode()
    let nonTexturedSpriteNodeFirst = SKSpriteNode()
    let nonTexturedSpriteNodeSecond = SKSpriteNode()
    let texturedSpriteNode = SKSpriteNode(imageNamed: "wow")
    
    override func didMove(to view: SKView){
        createText()
        createShapes()
        //nonTexturedSpriteNodeSecond.addChild(texturedSpriteNode)
        nonTexturedSpriteNodeFirst.addChild(nonTexturedSpriteNodeSecond)
        firstNode.addChild(nonTexturedSpriteNodeFirst)
        self.addChild(firstNode)
        self.addChild(texturedSpriteNode)
        
        firstNode.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        nonTexturedSKSpriteNodes()
        texturedSKSpriteNodes()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self){
            if texturedSpriteNode.contains(location){
                texturedSpriteNode.size = CGSize(width: texturedSpriteNode.size.width * 2, height: texturedSpriteNode.size.height * 2)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        if let location = touches.first?.location(in: self){
            if texturedSpriteNode.contains(position){
                texturedSpriteNode.position = location
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        if let location = touches.first?.location(in :self){
            if texturedSpriteNode.contains(location){
                texturedSpriteNode.size = CGSize(width: texturedSpriteNode.size.width * 0.5, height: texturedSpriteNode.size.height * 0.5)
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch cancelled")
    }
    
    func createShapes(){

    }
    
    func createText(){
 
    }
    
    func texturedSKSpriteNodes(){
        texturedSpriteNode.size = CGSize(width: 64, height: 64)
        texturedSpriteNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    func nonTexturedSKSpriteNodes(){
        nonTexturedSpriteNodeFirst.name = "first"
        nonTexturedSpriteNodeFirst.color = UIColor.blue
        nonTexturedSpriteNodeFirst.size = CGSize(width: 128, height: 128)
        nonTexturedSpriteNodeFirst.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        nonTexturedSpriteNodeSecond.name = "secodn"
        nonTexturedSpriteNodeSecond.color = UIColor.yellow
        nonTexturedSpriteNodeSecond.size = CGSize(width: 100, height:  100)
        nonTexturedSpriteNodeSecond.anchorPoint = CGPoint(x: 0.5, y:0.5)
        nonTexturedSpriteNodeSecond.position = CGPoint(x: 0, y: 0)
    }
    
}
