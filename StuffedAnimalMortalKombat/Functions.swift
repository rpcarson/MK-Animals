//
//  Functions.swift
//  StuffedAnimalMortalKombat
//
//  Created by Reed Carson on 6/11/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit


func degreesToRadian (value:Double) -> Double {
    
    return value * M_PI / 180.0
    
}

func DistanceBetweenPoint1(p1: CGPoint, andPoint2 p2: CGPoint) -> CGFloat {
    
    let xDist = (p2.x - p1.x)
    
    let yDist = (p2.y - p2.y)
    
    return sqrt((xDist * xDist) + (yDist * yDist))
}