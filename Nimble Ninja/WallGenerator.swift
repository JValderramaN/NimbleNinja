//
//  WallGenerator.swift
//  Nimble Ninja
//
//  Created by José Valderrama on 26/4/15.
//  Copyright (c) 2015 José Valderrama. All rights reserved.
//

import Foundation
import SpriteKit

class WallGenerator: SKSpriteNode {
    var generationTimer : NSTimer?
    var walls = [Wall]()
    
    func startGeneratingWallsEvery(seconds: NSTimeInterval){
        generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
    }
    
    func stopGenerating(){
        generationTimer?.invalidate()
    }
    func generateWall(){
        var scale : CGFloat
        let rand = arc4random_uniform(2)
        if rand == 0{
            scale = -1.0
        }else{
            scale = 1.0
        }
        
        let wall = Wall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale * (groundHeight/2 + wall.size.height/2)
        walls.append(wall)
        addChild(wall)
    }
    
    func stopWalls(){
        stopGenerating()
        for wall in walls{
            wall.stopMoving()
        }
    }
    
}
