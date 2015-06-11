//
//  Avatar.swift
//  StuffedAnimalMortalKombat
//
//  Created by Reed Carson on 6/10/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit



@IBDesignable class Avatar: UIView {
    
    @IBInspectable var healthPoints: CGFloat = 50
    @IBInspectable var energyPoints: CGFloat = 100
   
    @IBInspectable var healthColor: UIColor = UIColor.greenColor()
    @IBInspectable var energyColor: UIColor = UIColor.purpleColor()
    
    @IBInspectable var lightHealth: UIColor = UIColor.lightGrayColor()
    @IBInspectable var lightEnergy: UIColor = UIColor.lightGrayColor()

    
    override func drawRect(rect: CGRect) {
        
        //piece of paper
        let context = UIGraphicsGetCurrentContext()
        
        // bar width
        let lineWidth: CGFloat = 10
        CGContextSetLineWidth(context, lineWidth)
        
        // circle for bar
        let barRect = (CGRectInset(rect, lineWidth / 2, lineWidth / 2))
       
        // left bar
        lightHealth.set()
        CGContextStrokeEllipseInRect(context, barRect)
        
        //right bar
        CGContextSetBlendMode(context, kCGBlendModeSourceIn)
        lightEnergy.set()
        CGContextFillRect(context, CGRectMake(rect.width / 2, 0, rect.width / 2, rect.height))
     
        //remve other parts of circle
        CGContextSetBlendMode(context, kCGBlendModeClear)
        //         drawing hourglass
        CGContextMoveToPoint(context, 0, 0) // top left
        CGContextAddLineToPoint(context, rect.width, 0)  // top right
        CGContextAddLineToPoint(context, rect.width / 2, rect.height / 2) // cent
        CGContextAddLineToPoint(context, rect.width, rect.height) // bot right
        CGContextAddLineToPoint(context, 0, rect.height) //bottom left
        CGContextAddLineToPoint(context, rect.width / 2, rect.height / 2) //center
            CGContextFillPath(context)
        // draw
        
        //reset blend to normal
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        
        // add rounded ends to bar
        addDotAtDegrees(-135, WithColor: lightHealth, andContext: context)
        addDotAtDegrees(135, WithColor: lightHealth, andContext: context)
        addDotAtDegrees(-45, WithColor: lightEnergy, andContext: context)
        addDotAtDegrees(45, WithColor: lightEnergy, andContext: context)
        
       //add current health
        CGContextSetBlendMode(context, kCGBlendModeSourceIn)
        let healthY = (1.0 - (healthPoints / 100)) * rect.height
     
        healthColor.set()
      
        let degrees = Double((healthPoints / 100) * 90 + 135)
     
        let angle = CGFloat(degreesToRadian(degrees))
        
        let x = ((rect.width / 2) + (rect.width) * cos(angle))
        let y = ((rect.height / 2) + (rect.height) * sin(angle))

        
        CGContextMoveToPoint(context, x, y)
        CGContextAddLineToPoint(context, rect.width / 2, rect.height / 2)
        CGContextAddLineToPoint(context, 0, rect.height)
        CGContextFillPath(context)
        
        
        
        addDotAtDegrees(degrees, WithColor: healthColor, andContext: context)
        addDotAtDegrees(135, WithColor: healthColor, andContext: context)

      

        //add current energy
        
        
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        
        // avatar circle
        UIColor.lightGrayColor().set()
        let avatarRect = CGRectInset(rect, 15, 15)
        CGContextFillEllipseInRect(context, avatarRect)
        
    }
    
    func addDotAtDegrees(degrees: Double, WithColor color:UIColor, andContext context: CGContextRef) {
        
        let angle = CGFloat(degreesToRadian(degrees))
        
        let x = ((bounds.width / 2) + (bounds.width / 2 - 5) * cos(angle))
        let y = ((bounds.height / 2) + (bounds.height / 2 - 5) * sin(angle))
        
        println("x \(x) y \(y)")
        
        color.set()
        
        CGContextSetLineCap(context, kCGLineCapRound)
        
        CGContextMoveToPoint(context, x, y)
        CGContextAddLineToPoint(context, x, y)
        
        CGContextStrokePath(context)
        
    }
    
}


