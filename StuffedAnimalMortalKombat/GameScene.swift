//
//  GameScene.swift
//  StuffedAnimalMortalKombat
//
//  Created by Jo Albright on 6/9/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import SpriteKit

//protocol GameSceneRef {
//    
//    func playerJoined()
//    func playerLeft()
//}

class GameScene: SKScene /*GameSceneRef*/ {

    let playerCount: CGFloat = 8
    let statsPadding: CGFloat = 20
    var playerStatsWidth: CGFloat!
    
    override func didMoveToView(view: SKView) {
        
        
    playerStatsWidth = (view.bounds.width - (statsPadding * (playerCount + 1))) / playerCount
        
        
        Connector.sharedConnector().gameScene = self 
        
        
    }
    func playerJoined(name: String) {
        
        var  charNode = PlayerNode(color: UIColor.blackColor(), size: CGSizeMake(40, 40))
        
        charNode.name = name
       
        charNode.position = CGPointMake(500, 500)
       
        charNode.physicsBody = SKPhysicsBody(rectangleOfSize: charNode.size)
        
        if let info = Connector.sharedConnector().playersInfo[name] as? [String:AnyObject] {
            
            if let color = info["color"] as? UIColor {
            
            charNode.color = color
            
            }
            
        }
        
        addChild(charNode)
    
    }
    func playerLeft(name: String) {
        
        if let charNode = childNodeWithName(name) {
        
       charNode.removeFromParent()
        }
    }
    
    func playerJump(name: String) {
        if let charNode = childNodeWithName(name) {
            
            charNode.physicsBody?.applyImpulse(CGVectorMake(0.0, 20.0))
            
            
        }
        
    }
    func playerMove(direction: Int) {
        
        
    }
    func playerStop(name: String){
        
        
    }
    
    var sunRotation: Double = 0
    
    override func update(currentTime: CFTimeInterval) {
        
        if let sun = childNodeWithName("Sun") {
            
            let radius: CGFloat = 700
            
            sunRotation = sunRotation < 360 ? sunRotation + 0.05 : 0
            
            let angle = CGFloat(degreesToRadian(sunRotation))
            
            println(angle)
            sun.position.x = position.x + radius * cos(angle) + view!.center.x
            sun.position.y = position.y + radius * sin(angle) + view!.center.y

        }
    }
}

class PlayerNode: SKSpriteNode {
    
//    var name: String!
    
    
    
}

