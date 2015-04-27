//
//  GameScene.swift
//  Nimble Ninja
//
//  Created by José Valderrama on 26/4/15.
//  Copyright (c) 2015 José Valderrama. All rights reserved.
//

import SpriteKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var movingGround : MovingGround!
    var hero : Hero!
    var wallGenerator : WallGenerator!
    
    var textLabel: SKLabelNode!
    var pointLabel: SKLabelNode!
    var highPointLabel: SKLabelNode!
    
    var isStarted = false
    var isGameOver = false
    
    var pointsCount: Int = 0
    var highScore: Int!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //color cielo azul
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        
        movingGround = MovingGround(size: CGSizeMake(view.frame.size.width, groundHeight))
        movingGround.position = CGPointMake(0, view.frame.size.height / 2)
        addChild(movingGround)
        
        hero = Hero()
        hero.position = CGPointMake(70, movingGround.position.y + hero.frame.size.height / 2 + movingGround.frame.size.height / 2 )
        addChild(hero)
        
        wallGenerator = WallGenerator(color: UIColor.clearColor(), size: view.frame.size)
        wallGenerator.position = view.center
        addChild(wallGenerator)
        
        textLabel = SKLabelNode(text: "Tap to Start !")
        textLabel.position.x = view.center.x
        textLabel.position.y = view.center.y + 40
        textLabel.fontName = "Helvetica"
        textLabel.fontColor = UIColor.blackColor()
        textLabel.fontSize = 22.0
        addChild(textLabel)
        
        pointLabel = SKLabelNode(text: "0")
        pointLabel.position = CGPointMake(20.0, view.frame.size.height - 35)
        pointLabel.fontName = "Helvetica"
        pointLabel.fontColor = UIColor.blackColor()
        pointLabel.fontSize = 25.0
        addChild(pointLabel)
        
        highScore = defaults.integerForKey("highScore")
        highPointLabel = SKLabelNode(text: "\(highScore)")
        highPointLabel.position = CGPointMake(view.frame.size.width - 20, view.frame.size.height - 35)
        highPointLabel.fontName = "Helvetica"
        highPointLabel.fontColor = UIColor.blackColor()
        highPointLabel.fontSize = 25.0
        addChild(highPointLabel)
        
        physicsWorld.contactDelegate = self
    }
    
    func start(){
        textLabel.text = ""
        
        movingGround.start()
        isStarted = true
        hero.stop()
        
        wallGenerator.startGeneratingWallsEvery(1)
    }
    
    func gameOver(){
        
        if pointsCount > highScore{
            highPointLabel.text = pointLabel.text
            
            defaults.setInteger(pointsCount, forKey: "highScore")
        }

        textLabel.text = "GAME OVER"
        textLabel.fontColor = UIColor.whiteColor()
        textLabel.fontSize = 30.0
        
        isGameOver = true
        
        hero.physicsBody = nil
        wallGenerator.stopWalls()
        movingGround.stop()
    }
    
    func restart(){
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .AspectFill
        view!.presentScene(newScene)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if isGameOver {
          restart()
        }else if isStarted {
            hero.flip()
        }else{
            start()
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if wallGenerator.walls.count > 0 {
            let wall : Wall  = wallGenerator.walls[0]
            let wallLocation = wallGenerator.convertPoint(wall.position, toNode: self)
            
            if wallLocation.x < hero.position.x {
                wallGenerator.walls.removeAtIndex(0)
                pointsCount = ++pointsCount
                pointLabel.text = "\(pointsCount)"
            }
        }
        
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        gameOver()
    }
}
