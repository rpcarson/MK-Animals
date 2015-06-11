//
//  PawButton.swift
//  StuffedAnimalMortalKombat
//
//  Created by Reed Carson on 6/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

@IBDesignable class PawButton: UIButton {

    @IBInspectable var fillColor: UIColor = UIColor.cyanColor()
    @IBInspectable var pawColor: UIColor = UIColor.whiteColor()
    
    @IBInspectable var pawInset: CGFloat = 0


    override func drawRect(rect: CGRect) {
      
    
        let scaleX  = (rect.width - pawInset * 2) / 250
        let scaleY = (rect.height - pawInset * 2) / 250
        
        let context = UIGraphicsGetCurrentContext()
        fillColor.set()
        
        CGContextFillEllipseInRect(context, rect)
        
      CGContextTranslateCTM(context, pawInset, pawInset)
        CGContextScaleCTM(context, scaleX, scaleY)
        
        pawColor.set()
        
        
        let circles: [(CGFloat,CGFloat,CGFloat)] = [
        
         (133.6, 158.5, 63.6),
         (208, 85.4, 19.7),
         (42, 114, 19.7),
         (153.9, 54.2, 25.4),
         (82.4, 62.2, 28.3),
        
        ]

        for (cx,cy,r) in circles {
            
            
            CGContextFillEllipseInRect(context, CGRectMake(cx - r, cy - r, r * 2, r * 2))
        
        }
        
        
//        CGContextFillEllipseInRect(context, CGRectMake(133.6 - 63.6, 158.5 - 63.6, 63.6 * 2, 63.6 * 2))
//        
//        CGContextFillEllipseInRect(context, CGRectMake(208 - 19.7, 85.4 - 19.7, 19.7 * 2, 19.7 * 2))
//        
//            CGContextFillEllipseInRect(context, CGRectMake(42 - 19.7, 114 - 19.7, 19.7 * 2, 19.7 * 2))
//        
//            CGContextFillEllipseInRect(context, CGRectMake(153.9 - 25.4, 54.2 - 25.4, 25.4 * 2, 25.4 * 2))
//        
//            CGContextFillEllipseInRect(context, CGRectMake(82.4 - 28.3, 62.2 - 28.3, 28.3 * 2, 28.3 * 2))

        
        

        //       cx="133.6" cy="158.5" r="63.6"
//        cx="208" cy="85.4" r="19.7"
//        cx="42" cy="114" r="19.7"
//        cx="153.9" cy="54.2" r="25.4"
//        cx="82.4" cy="62.2" r="28.3"

}
}