//
//  LifeCount.swift
//  StuffedAnimalMortalKombat
//
//  Created by Reed Carson on 6/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit


@IBDesignable class LifeCount: UIView {

    @IBInspectable var statsLives: Int = 3 {
        
        didSet { setNeedsDisplay() }
        
    }
    
    @IBInspectable var padding: CGFloat = 5
    @IBInspectable var color: UIColor = UIColor.blackColor()
    
    override func drawRect(rect: CGRect) {
        
       let context = UIGraphicsGetCurrentContext()
        
        let hw = rect.height
        
        color.set()
        
        for i in 0..<statsLives {
            
           let x = rect.width - hw - ((hw + padding) * CGFloat(i))
            
            let lifeRect = CGRectMake(x, 0, hw, hw)
            
            CGContextFillEllipseInRect(context, lifeRect)
            
        }
    
    }

}
