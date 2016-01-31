//
//  GameScene.swift
//  ProtectYourBalls
//
//  Created by Wesley Chan on 7/13/15.
//  Copyright (c) 2015 Wesley Chan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
        
    

    override func touchesBegan(touches: NSObject, withEvent event: UIEvent) {
    /* Called when a touch begins */
        let welcomeNode = childNodeWithName("welcomeNode")
    
        if (welcomeNode != nil) {
            let fadeAway = SKAction.fadeOutWithDuration(0.5)
        
            welcomeNode?.runAction(fadeAway, completion: {
                let fade = SKTransition.fadeWithDuration(0.5)
                let ballScene = BallScene(fileNamed: "BallScene")
                self.view?.presentScene(ballScene, transition: fade)
            })
        }
    }
    
    
    
}
