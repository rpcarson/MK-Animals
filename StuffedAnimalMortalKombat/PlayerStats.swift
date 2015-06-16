//
//  PlayerStats.swift
//  StuffedAnimalMortalKombat
//
//  Created by Reed Carson on 6/12/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class PlayerStats: UIView {


    @IBOutlet weak var HealthBar: HealthBars!
    @IBOutlet weak var EnergyBar: HealthBars!
    
    
    @IBOutlet weak var killsCount: KillCount!
    @IBOutlet weak var livesCount: LifeCount!
   
    @IBOutlet weak var PlayerName: UILabel!


}
