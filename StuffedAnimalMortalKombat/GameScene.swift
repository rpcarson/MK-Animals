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