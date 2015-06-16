//
//  GameViewController.swift
//  StuffedAnimalMortalKombat
//
//  Created by Jo Albright on 6/9/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import SpriteKit
import MultipeerConnectivity

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    var scene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Connector.sharedConnector().gameBoard = self
        
        Connector.sharedConnector().startBrowsing()
        
        scene = GameScene.unarchiveFromFile("GameScene") as? GameScene
        
        if let scene = scene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }
    
    var playerViews: [PlayerStats] = []
    
    
    
    
    func playerJoined(peerID: MCPeerID) {
        
        if let playerVC = storyboard?.instantiateViewControllerWithIdentifier("playerStats") as? UIViewController {
            
            
            let playerView = playerVC.view as! PlayerStats
            
            playerView.PlayerName.text = peerID.displayName
            
            playerViews.append(playerView)
            
            
           scene?.playerJoined(peerID.displayName)
                
            }
        
        layoutPlayerStats()
    }
    
    func playerLeft(peerID: MCPeerID) {
        
        var foundPlayerViewIndex: Int?
        
        for (p,playerView) in enumerate(playerViews) {
            
            for playerView in playerViews {
                
                if let name = playerView.PlayerName.text, peerName = peerID.displayName where name == peerName {
                    
                    foundPlayerViewIndex = p
                    
                    scene?.playerLeft(name)
                }
                
                
            }
            
        }
        
        for playerView in playerViews { playerView.removeFromSuperview() }
        
        if let foundPlayerViewIndex = foundPlayerViewIndex {
            
            playerViews.removeAtIndex(foundPlayerViewIndex)
            
        }
        
        layoutPlayerStats()
            
        
        
        
       
    }
    
    func layoutPlayerStats() {
        
        let maxPlayers: CGFloat = 4
       
        let padding: CGFloat = 20
        
        let playerStatsWidth = (view.frame.width - (padding * (maxPlayers + 1))) / maxPlayers
        
        
        for (p,playerView) in enumerate(playerViews) {
            
           
            view.addSubview(playerView)
            
            
            let x = (playerStatsWidth + padding) * CGFloat(p) + padding
            
            
            playerView.frame = CGRectMake( x, padding,  playerStatsWidth, 300)
            
        }
        
        
        
    }
    
    
    
    
    // movement functions
    
    // attack functions
    
    
    
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
