//
//  GameViewController.swift
//  Nimble Ninja
//
//  Created by José Valderrama on 26/4/15.
//  Copyright (c) 2015 José Valderrama. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var scene : GameScene!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        //configure the view 
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        
        //create and configure the scene
        scene =  GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        //present the scene
        skView.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
