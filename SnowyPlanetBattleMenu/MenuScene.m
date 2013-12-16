//
//  SpaceshipScene.m
//  SpriteWalkthrough
//
//  Created by Matt Luedke on 7/9/13.
//  Copyright (c) 2013 Matt Luedke. All rights reserved.
//

#import "MenuScene.h"
#import "SpriteEndScene.h"

@implementation MenuScene

- (void)didMoveToView:(SKView *)view {
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}
- (void)createSceneContents {
    
    self.backgroundColor = [SKColor colorWithRed:191/255.0 green:223/255.0 blue:235/255.0 alpha:1.0];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    //add snowFlake!
    SKAction *makeSnowFlakes = [SKAction sequence: @[
                                                [SKAction performSelector:@selector(addSnowFlake) onTarget:self],
                                                [SKAction waitForDuration:1.0 withRange:0.15]
                                                ]];
    [self runAction: [SKAction repeatAction:makeSnowFlakes count:20]];
    
    
    // and buttons!
    [self makeButtons];
    
    // and a dancing title!
    
    SKLabelNode *dancingTitle = [self newDancingTitle];
    dancingTitle.position = CGPointMake(CGRectGetMidX(self.frame)-45, self.frame.size.height - 150);
    [self addChild:dancingTitle];
    
    
    // add snow!
    
    SKEmitterNode *snow = [self newSnowEmitter];
    snow.particlePosition = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height);
    snow.particlePositionRange = CGVectorMake(self.frame.size.width, 0.0);
    [self addChild:snow];
}

- (void)buttonChoice:(UIButton *)sender {
    
    SKNode *dancingTitle = [self childNodeWithName:@"dancingTitle"];
    
    CGPoint buttonCenter = CGPointMake(CGRectGetMidX(sender.frame), self.frame.size.height - CGRectGetMidY(sender.frame));
    
    SKAction *shootLightAndDisappear = [SKAction sequence:@[
                                                            [SKAction fadeAlphaTo:1.0 duration:0.2],
                                                            [SKAction scaleBy:4.0 duration:1.0],
                                                            [SKAction moveTo:[self convertPoint:buttonCenter toNode:dancingTitle] duration:0.5],
                                                            [SKAction removeFromParent]
                                                            ]];
    
    SKNode *light1 = [dancingTitle childNodeWithName:@"light1"];
    SKNode *light2 = [dancingTitle childNodeWithName:@"light2"];
    
     // stop all animations; we need all the frame rate we can get for this!!
    [light1 removeAllActions];
    [light2 removeAllActions];
    [self removeAllActions];
    [dancingTitle removeAllActions];
    
    [light1 runAction:shootLightAndDisappear];
    [light2 runAction:shootLightAndDisappear completion:^{
    
        // insert 'splosion!
        [sender removeFromSuperview];
        SKEmitterNode *splosion = [self newSplosion];
        splosion.particlePosition = buttonCenter;
        [self addChild:splosion];
        
        float duration = 2.0;
        
        [splosion runAction:[SKAction sequence:@[
                                                 [SKAction waitForDuration:duration],
                                                 [SKAction runBlock:^{
            splosion.particleBirthRate = 0;
        }],
                                                 [SKAction waitForDuration:splosion.particleLifetime + splosion.particleLifetimeRange],
                                                 [SKAction removeFromParent],
                                                 ]]
         
                 completion:^{
                 
                     // and... scene!
                     [[self.view subviews]
                      makeObjectsPerformSelector:@selector(removeFromSuperview)];
                     
                     SKScene* mainScene = [[SpriteEndScene alloc]
                                           initWithSize:self.size];
                     SKTransition *doors = [SKTransition
                                            doorsCloseHorizontalWithDuration:0.5];
                     [self.view presentScene:mainScene transition:doors];
                 
                 }];
    
    }];
    
}

-(void)makeButtons {
        
    SKNode *node1 = [SKNode new];
    node1.position = CGPointMake(self.button1.frame.origin.x + 0.5*self.button1.frame.size.width, self.frame.size.height - self.button1.frame.origin.y - 0.5*self.button1.frame.size.height);
    node1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.button1.frame.size];
    node1.physicsBody.dynamic = NO;
    node1.name = @"node";
    [self addChild:node1];
    
    SKNode *node2 = [SKNode new];
    node2.position = CGPointMake(self.button2.frame.origin.x + 0.5*self.button2.frame.size.width, self.frame.size.height - self.button2.frame.origin.y - 0.5*self.button2.frame.size.height);
    node2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.button2.frame.size];
    node2.physicsBody.dynamic = NO;
    node2.name = @"node";
    [self addChild:node2];
    
    SKNode *node3 = [SKNode new];
    node3.position = CGPointMake(self.button3.frame.origin.x + 0.5*self.button3.frame.size.width, self.frame.size.height - self.button3.frame.origin.y - 0.5*self.button3.frame.size.height);
    node3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.button3.frame.size];
    node3.physicsBody.dynamic = NO;
    node3.name = @"node";
    [self addChild:node3];
    
    SKNode *node4 = [SKNode new];
    node4.position = CGPointMake(self.button4.frame.origin.x + 0.5*self.button4.frame.size.width, self.frame.size.height - self.button4.frame.origin.y - 0.5*self.button4.frame.size.height);
    node4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.button4.frame.size];
    node4.physicsBody.dynamic = NO;
    node4.name = @"node";
    [self addChild:node4];
    
    SKNode *node5 = [SKNode new];
    node5.position = CGPointMake(self.button5.frame.origin.x + 0.5*self.button5.frame.size.width, self.frame.size.height - self.button5.frame.origin.y - 0.5*self.button5.frame.size.height);
    node5.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.button5.frame.size];
    node5.physicsBody.dynamic = NO;
    node5.name = @"node";
    [self addChild:node5];
    
    SKNode *node6 = [SKNode new];
    node6.position = CGPointMake(self.button6.frame.origin.x + 0.5*self.button6.frame.size.width, self.frame.size.height - self.button6.frame.origin.y - 0.5*self.button6.frame.size.height);
    node6.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.button6.frame.size];
    node6.physicsBody.dynamic = NO;
    node6.name = @"node";
    [self addChild:node6];
}

- (SKLabelNode *)newDancingTitle {
    SKLabelNode *dancingTitle = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    dancingTitle.name = @"dancingTitle";
    
    // TODO: make more swoopy
    [dancingTitle setText:@"Welcome!"];
    dancingTitle.fontColor = [SKColor yellowColor];
    dancingTitle.fontSize = 32.0;
    
    float hover_duration = 0.3;
    float movement_duration = 0.1;
    
    SKAction *hover = [SKAction sequence:@[
                                           [SKAction moveByX:0.0 y:5.0 duration:hover_duration],
                                           [SKAction moveByX:0.0 y:-5.0 duration:hover_duration],
                                           [SKAction moveByX:0.0 y:5.0 duration:hover_duration],
                                           [SKAction moveByX:0.0 y:-5.0 duration:hover_duration],
                                           
                                           [SKAction moveByX:0.0 y:-15.0 duration:movement_duration],
                                           [SKAction moveByX:10.0 y:-10.0 duration:movement_duration],
                                           [SKAction moveByX:20.0 y:-5.0 duration:movement_duration],
                                           [SKAction moveByX:30 y:0.0 duration:movement_duration],
                                           [SKAction moveByX:20.0 y:5.0 duration:movement_duration],
                                           [SKAction moveByX:10.0 y:10.0 duration:movement_duration],
                                           [SKAction moveByX:0.0 y:15.0 duration:movement_duration],
                                           
                                           [SKAction moveByX:0.0 y:5.0 duration:hover_duration],
                                           [SKAction moveByX:0.0 y:-5.0 duration:hover_duration],
                                           [SKAction moveByX:0.0 y:5.0 duration:hover_duration],
                                           [SKAction moveByX:0.0 y:-5.0 duration:hover_duration],
                                           
                                           [SKAction moveByX:0.0 y:-15.0 duration:movement_duration],
                                           [SKAction moveByX:-10.0 y:-10.0 duration:movement_duration],
                                           [SKAction moveByX:-20.0 y:-5.0 duration:movement_duration],
                                           [SKAction moveByX:-30 y:0.0 duration:movement_duration],
                                           [SKAction moveByX:-20.0 y:5.0 duration:movement_duration],
                                           [SKAction moveByX:-10.0 y:10.0 duration:movement_duration],
                                           [SKAction moveByX:0.0 y:15.0 duration:movement_duration]
                                           
                                           ]];
     
    hover.timingMode = SKActionTimingEaseInEaseOut;
    [dancingTitle runAction: [SKAction repeatActionForever:hover]];
    
    // add light one, it goes counterclockwise
    SKSpriteNode *light1 = [self newLightForward:YES];
    light1.position = CGPointMake(25.0, 6.0);
    [dancingTitle addChild:light1];
    
    // add light two, it goes clockwise
    SKSpriteNode *light2 = [self newLightForward:NO];
    light2.position = CGPointMake(45.0, 6.0);
    [dancingTitle addChild:light2];
    
    
    // physics! science!
    dancingTitle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:dancingTitle.frame.size];
    dancingTitle.physicsBody.dynamic = NO;
    
    return dancingTitle;
}

- (SKSpriteNode *)newLightForward:(BOOL)forward
{
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor
                                                               redColor] size:CGSizeMake(6,6)];
    
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeOutWithDuration:0.25],
                                           [SKAction fadeInWithDuration:0.25]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    blink.timingMode = SKActionTimingEaseInEaseOut;
    [light runAction: blinkForever];
    
    // this makes an octagon, not a circle! but the elliptical CGPath doesn't seem to work yet, and would be slower anyway
    float orbit_radius = 30.0;
    float rev_time = 2.0;
    
    SKAction *orbit = [SKAction sequence:@[
                                           [SKAction moveByX:0.0*orbit_radius y:0.5*orbit_radius duration:rev_time/9],
                                           [SKAction moveByX:-0.707*orbit_radius y:0.707*orbit_radius duration:rev_time/9],
                                           [SKAction moveByX:-1.0*orbit_radius y:0.0*orbit_radius duration:rev_time/9],
                                           [SKAction moveByX:-0.707*orbit_radius y:-0.707*orbit_radius duration:rev_time/9],
                                           [SKAction moveByX:0.0*orbit_radius y:-1.0*orbit_radius duration:rev_time/9],
                                           [SKAction moveByX:0.707*orbit_radius y:-0.707*orbit_radius duration:rev_time/9],
                                           [SKAction moveByX:1.0*orbit_radius y:0.0*orbit_radius duration:rev_time/9],
                                           [SKAction moveByX:0.707*orbit_radius y:0.707*orbit_radius duration:rev_time/9],
                                           [SKAction moveByX:0.0*orbit_radius y:0.5*orbit_radius duration:rev_time/9]
                                           ]];
    
    if (forward) {
        [light runAction:[SKAction repeatActionForever:orbit]];
        light.name = @"light1";
    } else {
        [light runAction:[SKAction repeatActionForever:[orbit reversedAction]]];
        light.name = @"light2";
    }
    
    return light;
}


static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}

- (void) addSnowFlake {
    
    SKSpriteNode *snowFlake = [[SKSpriteNode alloc] initWithColor:[SKColor
                                                              whiteColor] size:CGSizeMake(4,4)];
    snowFlake.position = CGPointMake(skRand(0, self.size.width),
                                self.size.height-50);
    snowFlake.name = @"snowFlake";
    snowFlake.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:snowFlake.size];
    snowFlake.physicsBody.mass = 0.0007;
    snowFlake.physicsBody.usesPreciseCollisionDetection = NO;
    
    // slow down the snowflakes, otherwise they fall like stones
 //   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:(0.010) target:self selector:@selector(slowDown:) userInfo:snowFlake repeats:YES];

    [self addChild:snowFlake];
    
    // this is important for frame rate!
    [self performSelector:@selector(meltSnowFlake:) withObject:snowFlake afterDelay:5.0];
    
}

- (void)slowDown:(NSTimer *)fallingTimer {
    CGFloat thrust = skRand(0.55, 0.68);
    CGFloat shipDirection = skRand(1.41, 1.73);
  //  NSLog(@"dir %.2f", shipDirection);
    CGVector thrustVector = CGVectorMake(thrust*cosf(shipDirection),
                                       thrust*sinf(shipDirection));
    SKSpriteNode *snowFlake = (SKSpriteNode *)fallingTimer.userInfo;
    [snowFlake.physicsBody applyForce:thrustVector];
    
}

- (void)meltSnowFlake:(SKNode *)snowFlake {
    
    [snowFlake removeFromParent];
    
    [self addSnowFlake];
}

-(void)didSimulatePhysics
{
    // for frame rate reasons, once a snowFlake falls below 0 it is removed (otherwise it actually still exists, just off the screen!)
    
    [self enumerateChildNodesWithName:@"snowFlake" usingBlock:^(SKNode *node,
                                                           BOOL *stop) {
        if (node.position.y < 0) {
            [node removeFromParent];
        }
    }];
}

// trying to make background snow

- (SKEmitterNode*) newSnowEmitter
{
    NSString *snowPath = [[NSBundle mainBundle] pathForResource:@"Snow"
                                                           ofType:@"sks"];
    SKEmitterNode *snow = [NSKeyedUnarchiver unarchiveObjectWithFile:snowPath];
    return snow;
}

- (SKEmitterNode*) newSplosion
{
    NSString *splosionPath = [[NSBundle mainBundle] pathForResource:@"Splosions"
                                                         ofType:@"sks"];
    SKEmitterNode *splosion = [NSKeyedUnarchiver unarchiveObjectWithFile:splosionPath];
    return splosion;
}


@end
