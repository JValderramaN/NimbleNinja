//
//  MovingGround.swift
//  Nimble Ninja
//
//  Created by José Valderrama on 26/4/15.
//  Copyright (c) 2015 José Valderrama. All rights reserved.
//

import Foundation
import SpriteKit

class MovingGround: SKSpriteNode  {
    
    let NUMBER_OF_SEGMENTS = 20
    //color verde oscuro
    let COLOR_ONE = UIColor(red: 88.0/255.0, green: 148.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    //color verde claro
    let COLOR_TOW = UIColor(red: 120.0/255.0, green: 195.0/255.0, blue: 110.0/255.0, alpha: 1.0)
    
    init(size : CGSize){
        super.init(texture: nil, color: UIColor.brownColor(), size: CGSizeMake(size.width * 2, size.height))
        anchorPoint = CGPointMake(0.0, 0.5)
        
        for var i = 0 ; i < NUMBER_OF_SEGMENTS ; i++ {
            var segmentColor : UIColor!
            if i % 2 == 0 {
                segmentColor = COLOR_ONE
            }else{
                segmentColor = COLOR_TOW
            }
            
            let segment = SKSpriteNode(color: segmentColor, size: CGSizeMake(self.size.width / CGFloat(NUMBER_OF_SEGMENTS), self.size.height))
            //segment.anchorPoint = CGPointMake(0.0, 0.5)
            segment.position = CGPointMake(CGFloat(i) *  segment.size.width, 0.0)
            addChild(segment)            
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(){
        let adjustedDuration = NSTimeInterval(frame.size.width / defaultXToMovePerSecond)
        let moveLeft = SKAction.moveByX(-frame.size.width / 2, y: 0, duration: adjustedDuration/2)
        let resetPosition = SKAction.moveToX(0, duration: 0)
        let moveSequence = SKAction.sequence([moveLeft,resetPosition])
        runAction(SKAction.repeatActionForever(moveSequence))
    }
    
    func stop(){
        removeAllActions()
    }
    
}