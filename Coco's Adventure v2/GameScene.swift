//
//  GameScene.swift
//  Coco's Adventure v1
//
//  Created by Kevin Cheng on 6/16/15.
//  Copyright (c) 2015 Kevin Cheng. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var dog = SKSpriteNode();
    var myLabel = SKLabelNode();
    var scoreLabel = SKLabelNode();
    var beanbagTexture = SKTexture();
    var moveAndRemove = SKAction();
    var groundTexture = SKTexture();
    var points = 0;
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //title
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Coco's Adventure!";
        myLabel.fontSize = 30;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) * 1.25);
        self.addChild(myLabel)
        myLabel.runAction(SKAction.fadeAlphaTo(0.0, duration: 3.0));
        
        //score
        let scoreLabel = SKLabelNode(fontNamed:"Chalkduster");
        scoreLabel.text = "Score: " + points.description;
        scoreLabel.fontSize = 20;
        scoreLabel.position = CGPoint(x: self.frame.size.width * 0.63, y: self.frame.size.height * 0.97);
        scoreLabel.fontColor = UIColor.whiteColor();
        self.addChild(scoreLabel);
        
        //music
        
        
        //dog
        var dogTexture = SKTexture(imageNamed: "dogFace");
        dogTexture.filteringMode = SKTextureFilteringMode.Nearest; //WHAT IS FILTERING?
        
        dog = SKSpriteNode(texture: dogTexture);
        dog.setScale(0.15);
        dog.position = CGPoint(x: self.frame.size.width * 0.4, y: self.frame.size.height * 0.6);
        //CANT CHANGE DOG'S LOCATION
        
        dog.physicsBody = SKPhysicsBody(circleOfRadius: dog.size.height * 0.5);
        dog.physicsBody?.dynamic = true;
        dog.physicsBody?.allowsRotation = false;
        self.addChild(dog);
        
        //ground
        groundTexture = SKTexture(imageNamed: "blueRect");
        
        var groundSprite = SKSpriteNode(texture: groundTexture);
        groundSprite.setScale(0.15);
        groundSprite.position = CGPoint(x: self.size.width / 2.0, y: groundSprite.size.height / 2.0);
        self.addChild(groundSprite);
        
        var ground = SKNode();
        ground.position = CGPoint(x: 0, y: 0);
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width * 2.0, groundTexture.size().height * 0.3));
        ground.physicsBody?.dynamic = false;
        self.addChild(ground);
        
        //ceiling
        var ceiling = SKNode();
        ceiling.position = CGPoint(x: 0, y: self.frame.size.height * 0.95);
        ceiling.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, self.frame.size.height * 0.025));
        ceiling.physicsBody?.dynamic = false;
        self.addChild(ceiling);
        
        //beanbags
        beanbagTexture = SKTexture(imageNamed: "beanbag");
        
        //movement of beanbags
        let distanceToMove = CGFloat(self.frame.size.width + beanbagTexture.size().width * 0.6);
        let moveBeanbag = SKAction.moveByX(-distanceToMove, y: 0.0, duration: NSTimeInterval(0.0015 * distanceToMove));
        let removeBeanbag = SKAction.removeFromParent();
        moveAndRemove = SKAction.sequence([moveBeanbag, removeBeanbag]);
        
        //spawn beanbags
        let spawn = SKAction.runBlock({() in self.spawnBeanbag()}); //understand this later
        let delay = SKAction.waitForDuration(NSTimeInterval(3.0));
        let spawnThenDelay = SKAction.sequence([spawn, delay]);
        let spawnThenDelayForever = SKAction.repeatActionForever(spawnThenDelay);
        self.runAction(spawnThenDelayForever);
        
        //laser beams
        
    }
    
    func spawnBeanbag() {
        var beanbag = SKSpriteNode(texture: beanbagTexture);
        beanbag.setScale(0.3);
        beanbag.position = CGPoint(x: self.frame.size.width * 1.5,  y: groundTexture.size().height * 0.22);
        beanbag.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(beanbagTexture.size().width * 0.25, beanbagTexture.size().height * 0.15));
        beanbag.physicsBody?.dynamic = false;
        beanbag.runAction(moveAndRemove);
        self.addChild(beanbag);
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if (dog.physicsBody?.velocity.dy == 0)
            {
                dog.physicsBody?.applyImpulse(CGVectorMake(0, 230)); // only can jump once
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
