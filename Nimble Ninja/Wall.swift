//
//  Wall.swift
//  Nimble Ninja
//
//  Created by José Valderrama on 26/4/15.
//  Copyright (c) 2015 José Valderrama. All rights reserved.
//

import Foundation
import SpriteKit

class Wall: SKSpriteNode {
    let WALL_WIDTH: CGFloat = 30.0
    let WALL_HEIGHT: CGFloat = 50.0
    let WALL_COLOR = UIColor.blackColor()
    
    override init(){
        let size = CGSizeMake(WALL_WIDTH, WALL_HEIGHT)
        super.init(texture: nil, color: WALL_COLOR, size: size)
        
        loadPhisicsBodyWithSIze(size)
        startMoving()
    }
    
    func loadPhisicsBodyWithSIze(size: CGSize){
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = wallCategory
        physicsBody?.affectedByGravity = false
    }
    
    func startMoving(){
        let moveLeft = SKAction.moveByX(-defaultXToMovePerSecond, y: 0, duration: 1)
        runAction(SKAction.repeatActionForever(moveLeft))
    }
    
    func stopMoving(){
        removeAllActions()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}