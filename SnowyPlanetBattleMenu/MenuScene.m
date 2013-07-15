//
//  SpaceshipScene.m
//  SpriteWalkthrough
//
//  Created by Matt Luedke on 7/9/13.
//  Copyright (c) 2013 Matt Luedke. All rights reserved.
//

#import "MenuScene.h"
#import "SpriteMainScene.h"

@implementation MenuScene

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}
- (void)createSceneContents
{
    self.backgroundColor = [SKColor colorWithRed:120.0/255.0 green:180.0/255.0 blue:230.0/255.0 alpha:1.0];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    //add snowFlake!
    SKAction *makeSnowFlakes = [SKAction sequence: @[
                                                [SKAction performSelector:@selector(addSnowFlake) onTarget:self],
                                                [SKAction waitForDuration:0.10 withRange:0.15]
                                                ]];
    [self runAction: [SKAction repeatActionForever:makeSnowFlakes]];
    
    
    // and buttons!
    [self makeButtons];
    
    // and a dancing title!
    SKLabelNode *dancingTitle = [self newDancingTitle];
    dancingTitle.position = CGPointMake(CGRectGetMidX(self.frame)-45, self.frame.size.height - 150);
    [self addChild:dancingTitle];
    
    // add snow!
    SKEmitterNode *snow = [self newSnowEmitter];
    snow.particlePosition = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height);
    snow.particlePositionRange = CGPointMake(self.frame.size.width, 0.0);
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
                     
                     SKScene* mainScene = [[SpriteMainScene alloc]
                                           initWithSize:self.size];
                     SKTransition *doors = [SKTransition
                                            doorsCloseHorizontalWithDuration:0.5];
                     [self.view presentScene:mainScene transition:doors];
                 
                 }];
    
    }];
    
}

-(void)makeButtons {
    
    for (int i = 0; i < 6; i++){
        
        // crazy math!
        CGFloat button_x = (50 + 50*i)*(-1)*((i/3)-1) + (self.frame.size.width - 350 + 50*(i%3))*(i/3);
        CGFloat button_y = (300 + 200*i)*(-1)*((i/3)-1) + (700 - 200*(i%3))*(i/3);
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(button_x, button_y, 200, 90)];
        [button setBackgroundImage:[UIImage imageNamed:@"easy_button.png"] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"Option %i", (i+1)] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:28.0]];
        [button addTarget:self action:@selector(buttonChoice:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        SKNode *node = [SKNode new];
        node.position = CGPointMake(button_x + 100, self.frame.size.height - button_y - 45);
        node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:button.frame.size];
        node.physicsBody.dynamic = NO;
        node.name = @"node";
        [self addChild:node];
        
        
    }
    
}

- (SKLabelNode *)newDancingTitle
{
    SKLabelNode *dancingTitle = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    dancingTitle.name = @"dancingTitle";
    
    // TODO: make more swoopy
    [dancingTitle setText:@"Welcome!"];
    dancingTitle.fontColor = [SKColor yellowColor];
    dancingTitle.fontSize = 72.0;
    
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

- (void) addSnowFlake
{
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
    [self performSelector:@selector(meltSnowFlake:) withObject:snowFlake afterDelay:35.0];
    
}

- (void)slowDown:(NSTimer *)fallingTimer {
    CGFloat thrust = skRand(0.55, 0.68);
    CGFloat shipDirection = skRand(1.41, 1.73);
  //  NSLog(@"dir %.2f", shipDirection);
    CGPoint thrustVector = CGPointMake(thrust*cosf(shipDirection),
                                       thrust*sinf(shipDirection));
    SKSpriteNode *snowFlake = (SKSpriteNode *)fallingTimer.userInfo;
    [snowFlake.physicsBody applyForce:thrustVector];
    
}

- (void)meltSnowFlake:(SKNode *)snowFlake {
    
    [snowFlake removeFromParent];
    
}

-(void)didSimulatePhysics
{
    // for frame rate reasons, once a snowFlake falls below 0 it is removed (otherwise it actually still exists, just off the screen!)
    
    [self enumerateChildNodesWithName:@"snowFlake" usingBlock:^(SKNode *node,
                                                           BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
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
