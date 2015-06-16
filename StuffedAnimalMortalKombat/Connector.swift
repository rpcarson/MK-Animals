//
//  Connector.swift
//  StuffedAnimalMortalKombat
//
//  Created by Jo Albright on 6/9/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import MultipeerConnectivity

private let serviceType = "SAMK"
private let _singleton = Connector()

class Connector: NSObject, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate {
    
    class func sharedConnector() -> Connector { return _singleton }
    
    var browser: MCNearbyServiceBrowser? // iPad
    var advertiser: MCNearbyServiceAdvertiser? // iPhone
    
    var session: MCSession?
    
    var myPeerID: MCPeerID?
    
    var playersInfo: [String:AnyObject] = [:]
    
    var worldID: MCPeerID?
    
    var myInfo: [String:AnyObject] = [:
       
//        "color":UIColor(red:0.52, green:0.83, blue:0.97, alpha:1)
        
    
    ]
    
    var gameBoard: GameViewController?
    
    var controller: ControllerViewController?
    
    var gameScene: GameScene?
    
    func startBrowsing() { // iPad
        
        myPeerID = MCPeerID(displayName: "World")
        
        session = MCSession(peer: myPeerID)
        session?.delegate = self
        
        browser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
        browser?.delegate = self
        
        browser?.startBrowsingForPeers()
        
    }
    
    func startAdvertising() { // iPhone
        
        myPeerID = MCPeerID(displayName: "Purity")
        
        session = MCSession(peer: myPeerID)
        session?.delegate = self
        
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: myInfo, serviceType: serviceType)
        advertiser?.delegate = self
        
        advertiser?.startAdvertisingPeer()
        
    }
    
    ////////// MARK: BROWSER DELEGATE
    
    func browser(browser: MCNearbyServiceBrowser!, foundPeer peerID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) {
        
        println("found " + peerID.displayName)
        println("found info \(info)")
        
        
        playersInfo[peerID.displayName] = info 
        
        //inviting the peer
        
        
        browser.invitePeer(peerID, toSession: session, withContext: nil, timeout: 30)
        
    }
    
    func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!) {
        
        println("lost " + peerID.displayName)
        
    }
    
    ////////// MARK: ADVERTISER DELEGATE
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) {
        
        println("invitation from " + peerID.displayName)
        
        worldID = peerID
        
        // accepting invite
        invitationHandler(true,session)
        
    }
    
    ////////// MARK: SESSION DELEGATE
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        
        decideActionWithData(data, andPeerID: peerID)
        
        
  
    
    
    
    
    
    
    
    
    
    
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        
        let stateArray = [
            "Not Connected",
            "Connecting",
            "Connected"
        ]
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            
            switch state {
                
            case .NotConnected : // not connected
                self.gameBoard?.playerLeft(peerID)
                println("eeeee")
                
            case .Connecting : // connecting
                
                println("/(stateArray[state.rawValue]) to " + peerID.displayName)
                
            case .Connected : // connected
                
                self.gameBoard?.playerJoined(peerID)
                
                
            }
        })
    }

///////////// MARK: DATA HALDELING
    
    func sendDataToWorld(data:NSData) {
        
        if let worldID = worldID {
            
            session?.sendData(data, toPeers: [worldID], withMode: MCSessionSendDataMode.Reliable, error: nil)
            
        }
        
    }
    

    func decideActionWithData(data: NSData, andPeerID peerID: MCPeerID) {
        
        if let info = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as? [String:AnyObject] {
            
            println(info)
            
            
            if let action = info["action"] as? String {
                
                if action == "jump" {
                    
                    gameScene?.playerJump(peerID.displayName)
                }
            }
            
            
        }
        
        
    }






}



