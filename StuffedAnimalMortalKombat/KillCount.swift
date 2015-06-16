//
//  KillCount.swift
//  StuffedAnimalMortalKombat
//
//  Created by Reed Carson on 6/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

@IBDesignable class KillCount: UIView {

    @IBInspectable var statsKills: UInt8 = 12 {
        
        didSet {
            
            setNeedsDisplay()
            
        }
    }
    
    
    @IBInspectable var padding: CGFloat = 5
    @IBInspectable var color: UIColor = UIColor.blackColor()
    @IBInspectable var killsPerLine: CGFloat = 10
    
    override func drawRect(rect: CGRect) {

        let context = UIGraphicsGetCurrentContext()
        
       color.set()
        
        
        let hw = (rect.width - ((killsPerLine - 1) * padding)) / killsPerLine
        
        for i in 0..<statsKills {
            
            let x = (hw + padding) * (CGFloat(i) % killsPerLine)
            let y = (hw + padding) * floor(CGFloat(i) / killsPerLine)
            
            CGContextFillEllipseInRect(context, CGRectMake(x, y, hw, hw))
            
            
        }
        
        
    
    }


}
