//
//  BallScene.swift
//  ProtectYourBalls
//
//  Created by Wesley Chan on 8/9/15.
//  Copyright (c) 2015 Wesley Chan. All rights reserved.
//

import UIKit
import SpriteKit

class BallScene: SKScene, SKPhysicsContactDelegate {
    // Variables
    var score = 0
    var health = 5
    var gameOver: Bool?
    let maxNumberOfBalls = 15    // Max number of ships allowed on screen
    var currentNumberOfBalls : Int?  // Keeps track of number of ships on screen
    var timeBetweenBalls: Double?
    var moverSpeed = 10.0    // How long it takes for ship to move to bottom of the screen
    let moveFactor = 1.02   // Move factor to speed up ships
    var now: NSDate?        // Time variables
    var nextTime: NSDate?   // Time variables
    var gameOverLabel: SKLabelNode?
    var scoreLabel: SKLabelNode?
    
    // Physics body category bitmasks
    // ------------------------------
    // We'll use these to determine ball collisions
    let firstBallCategory: UInt32 = 0x1 << 0
    let badBallsCategory: UInt32 = 0x1 << 1
    
    // Entry point into game; Gets called first
    // Use to call initializeValues function
    override func didMoveToView(view: SKView) {
        initializeValues()
        physicsWorld.gravity = CGVector(0, 0) // no gravity
        self.physicsWorld.contactDelegate = self // We'll handle contact between physics bodies in this class
    }
    
    // Sets initial values for variables
    func initializeValues() {
        //An SKScene has children. Children can be anything from our balls to our labels. When we restart the game, the first thing to do is remove all the children from the scene.
        self.removeAllChildren()
        score = 0
        gameOver = false
        currentNumberOfBalls = 0
        timeBetweenBalls = 2.5  // Seconds
        moverSpeed = 10.0   // Seconds
        health = 5
        nextTime = NSDate()
        now = NSDate()
        
        // Spawn Center Balls
        let firstBall = SKSpriteNode(imageNamed: "ball")
        firstBall.name = "FirstBall"
        firstBall.position = CGPointMake(CGRectGetMidX(self.frame)-50, CGRectGetMidY(self.frame))
        firstBall.xScale = 0.25
        firstBall.yScale = 0.25
        firstBall.color = SKColor.greenColor()
        firstBall.colorBlendFactor = 1.0
        firstBall.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        firstBall.physicsBody?.dynamic = true
        firstBall.physicsBody?.categoryBitMask = firstBallCategory
        firstBall.physicsBody?.contactTestBitMask = badBallsCategory
        firstBall.physicsBody?.collisionBitMask = 0
        self.addChild(firstBall)
        
        let secondBall = SKSpriteNode(imageNamed: "ball")
        secondBall.name = "FirstBall"
        secondBall.position = CGPointMake(CGRectGetMidX(self.frame)+50, CGRectGetMidY(self.frame))
        secondBall.xScale = 0.25
        secondBall.yScale = 0.25
        secondBall.color = SKColor.greenColor()
        secondBall.colorBlendFactor = 1.0
        secondBall.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        secondBall.physicsBody?.categoryBitMask = firstBallCategory
        secondBall.physicsBody?.contactTestBitMask = badBallsCategory
        secondBall.physicsBody?.collisionBitMask = 0
        self.addChild(secondBall)
        
        // Set up health label
        scoreLabel = SKLabelNode(fontNamed:"System")   // Font
        scoreLabel?.text = "Score: \(score)"   // Display health score
        scoreLabel?.fontSize = 30
        scoreLabel?.fontColor = SKColor.blackColor()
        scoreLabel?.position = CGPoint(x:CGRectGetMinX(self.frame) + 170, y:(CGRectGetMinY(self.frame) + 100)); // finds bottom left corner of screen and then adds 80 and 100 as buffers
        
        // Puts healthLabel into the scene
        self.addChild(scoreLabel!)
        
        
    }
    
    
    
    // Called before each frame is rendered
    override func update(currentTime: CFTimeInterval) {
        // Updates the health level for each frame; Also changes color of label if health below 3
        scoreLabel?.text = "Score: \(score)"
        
        now = NSDate()
        if (currentNumberOfBalls < maxNumberOfBalls && // Checks to see if we have enough room on screen to create ship
            now?.timeIntervalSince1970 > nextTime?.timeIntervalSince1970) && // Check to see if it's time to make a new ship
            gameOver == false
        { // Check if we're not dead
            
            // Spawning the bad balls
            //--------------------------------------------
            // Specifies when the next ship can be made (*)
            nextTime = now?.dateByAddingTimeInterval(NSTimeInterval(timeBetweenBalls!))
            
            // Horizontal spawn point for our ship (1024 horizontal pixels on screen)
            var newXVert = Int(arc4random()%750)
            var newXHorz = Int(self.frame.width+10)
            var newXVert1 = Int(arc4random()%750)
            // Height of screen +10 to add some buffer room for ships
            var newYVert = Int(self.frame.height+10)
            var newYHorz = Int(arc4random()%1024)
            var newYHorz1 = Int(arc4random()%1024)
            // Spawn point variables
            var spawnPointVert = CGPoint(x:newXVert,y:newYVert)
            var spawnPointHorz = CGPoint(x: newXHorz, y: newYHorz)
            var spawnPointVert1 = CGPoint(x:newXVert1,y:-newYVert)
            var spawnPointHorz1 = CGPoint(x:-newXHorz, y: newYHorz1)
            
            // Destination has same x point and y: bottom of the screen
            var destinationVertUp =  CGPoint(x:newXVert, y:-50.0)
            var destinationVertDown = CGPoint(x: newXVert1, y: 1330)
            var destinationHorzUp = CGPoint(x: -200.0, y: newYHorz)
            var destinationHorzDown = CGPoint(x: 900, y: newYHorz1)
            
            
            // Call createShip function passing spawn points and destination to it as values
            var randomCreateShip = Int(arc4random_uniform(4))
            if (randomCreateShip == 0) {
                createBalls(spawnPointVert, destination: destinationVertUp)
            }
            else if (randomCreateShip == 1){
                createBalls(spawnPointVert1, destination: destinationVertDown)
            }
            else if (randomCreateShip == 2) {
                createBalls(spawnPointHorz1, destination: destinationHorzDown)
            }
            else {
                createBalls(spawnPointHorz, destination: destinationHorzUp)
            }
            
            //--------------------------------------------------
            
            
            //Make ship speed faster and faster
            moverSpeed = moverSpeed/moveFactor
            
            // Make ships spawn faster and faster
            timeBetweenBalls = timeBetweenBalls!/moveFactor
        }
        
        // Regardless of whether a ship is ready to spawn or not, we will also check if any ships reach the bottom of the screen and if the game is over.
        //checkIfBallsReachTheBottom()
    }
    
    // Actual Create Balls Function definition
    func createBalls(spawnPoint:CGPoint, destination:CGPoint) {
        // Create our SKSpriteNode and pass it an image name (Provided by Apple)
        let badBalls = SKSpriteNode(imageNamed: "ball")
        badBalls.name = "Destroyable"
        badBalls.xScale = 0.25
        badBalls.yScale = 0.25
        badBalls.position = spawnPoint
        badBalls.color = SKColor.redColor()
        badBalls.colorBlendFactor = 1.0
        badBalls.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        badBalls.physicsBody?.dynamic = true
        badBalls.physicsBody?.categoryBitMask = badBallsCategory
        badBalls.physicsBody?.contactTestBitMask = firstBallCategory
        badBalls.physicsBody?.collisionBitMask = 0
        badBalls.physicsBody?.usesPreciseCollisionDetection = true
        
        // Creates ships movement parameters
        let duration = NSTimeInterval(moverSpeed)
        let action = SKAction.moveTo(destination, duration: duration)
        
        // Ship movement action call
        badBalls.runAction(SKAction.repeatActionForever(action))
        
        // Increase number of current ships on screen and add sprite to scene
        currentNumberOfBalls? += 1
        self.addChild(badBalls)
    }
    
    // Dragging green balls
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var nodeTouched = SKNode()
        var currentNodeTouched = SKNode()
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if let theName = self.nodeAtPoint(location).name{
                if theName == "FirstBall" {
                    let location = touch.locationInNode(self)
                    nodeTouched = self.nodeAtPoint(location)
                    nodeAtPoint(location).position = location
                }
            }
        }
    }
    
    
    // Called when a touch begins
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // Iterate through every touch
        for touch: AnyObject in touches {
            // Checks if we are on game over screen, and if so calls initializeValues to remove all children in scene and restart game
            if (gameOver? == true) {
                initializeValues()
            }
        }
    }
    
    // SKPhysicsContactDelegate method: called whenever two physics bodies first contact each other
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody!
        var secondBody: SKPhysicsBody!
        
        // An SKPhysicsContact object is created when 2 physics bodies make contact,
        // and those bodies are referenced by its bodyA and bodyB properties.
        // We want to sort these bodies by their bitmasks so that it's easier
        // to identify which body belongs to which sprite.
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
    
        // We only care about badball-goodball contacts.
        // If the contact is badball-goodball, firstBody refers to the firstball's physics body,
        // and second body refers to the badball's physics body.
        if (firstBody.categoryBitMask & firstBallCategory) != 0 &&
            (secondBody.categoryBitMask & badBallsCategory) != 0 {
                self.removeAllChildren()
                showGameOverScreen()
                gameOver = true
        }
    }
    
    // Check if ship has reached bottom of screen
    /*func checkIfBallsReachTheBottom(){
        // Iterate through every child in the scene and look at its y-position
        for child in self.children {
            // If y-position is 0, remove child from scene
            if(child.position.y == 0){
                self.removeChildrenInArray([child])
                currentNumberOfBalls?-=1
                health += 1
            }
        }
    }*/

    
    // Display Game Over screen
    func showGameOverScreen(){
        gameOverLabel = SKLabelNode(fontNamed:"System")
        gameOverLabel?.text = "Game Over! Score: \(score)"
        gameOverLabel?.fontColor = SKColor.redColor()
        gameOverLabel?.fontSize = 65;
        gameOverLabel?.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(gameOverLabel!)
    }
    
   
}
