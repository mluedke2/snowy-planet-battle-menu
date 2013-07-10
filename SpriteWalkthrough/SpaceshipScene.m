//
//  SpaceshipScene.m
//  SpriteWalkthrough
//
//  Created by Matt Luedke on 7/9/13.
//  Copyright (c) 2013 Matt Luedke. All rights reserved.
//

#import "SpaceshipScene.h"

@implementation SpaceshipScene

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
    // 70-130-180
    self.backgroundColor = [SKColor colorWithRed:120.0/255.0 green:180.0/255.0 blue:230.0/255.0 alpha:1.0];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    /*
    // add spaceship!
    SKSpriteNode *spaceship = [self newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame)-150,
                                     CGRectGetMidY(self.frame)-250);
    [self addChild:spaceship];
  */
    
    
    //add rocks!
    SKAction *makeRocks = [SKAction sequence: @[
                                                [SKAction performSelector:@selector(addRock) onTarget:self],
                                                [SKAction waitForDuration:0.10 withRange:0.15]
                                                ]];
    [self runAction: [SKAction repeatActionForever:makeRocks]];
    
    
    // and buttons!
    [self makeButtons];
    
    // and a title!
  //  [self makeTitle];
    
    // or maybe a dancing title!
    SKLabelNode *dancingTitle = [self newDancingTitle];
    dancingTitle.position = CGPointMake(CGRectGetMidX(self.frame)-45, self.frame.size.height - 150);
    [self addChild:dancingTitle];
    
    // add snow!
    SKEmitterNode *snow = [self newSnowEmitter];
    snow.particlePosition = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height);
    snow.particlePositionRange = CGPointMake(self.frame.size.width, 0.0);
//    snow.emissionAngleRange = 100.0;
    [self addChild:snow];

}

- (void)makeTitle{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.frame)-200, 75, 400, 150)];
    [titleLabel setText:@"Welcome!"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:52.0]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:titleLabel];
    
}

-(void)makeButtons {
    
    // TODO: DRY this into a for loop (trick is getting the frames calculated right!)
  
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 200, 90)];
    [button1 setBackgroundImage:[UIImage imageNamed:@"easy_button.png"] forState:UIControlStateNormal];
    [button1 setTitle:@"Option 1" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:28.0]];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 200, 90)];
    [button2 setBackgroundImage:[UIImage imageNamed:@"easy_button.png"] forState:UIControlStateNormal];
    [button2 setTitle:@"Option 2" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:28.0]];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(150, 700, 200, 90)];
    [button3 setBackgroundImage:[UIImage imageNamed:@"easy_button.png"] forState:UIControlStateNormal];
    [button3 setTitle:@"Option 3" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button3.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:28.0]];
    [self.view addSubview:button3];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-350, 700, 200, 90)];
    [button4 setBackgroundImage:[UIImage imageNamed:@"easy_button.png"] forState:UIControlStateNormal];
    [button4 setTitle:@"Option 4" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button4.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:28.0]];
    [self.view addSubview:button4];
    
    UIButton *button5 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-300, 500, 200, 90)];
    [button5 setBackgroundImage:[UIImage imageNamed:@"easy_button.png"] forState:UIControlStateNormal];
    [button5 setTitle:@"Option 5" forState:UIControlStateNormal];
    [button5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button5.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:28.0]];
    [self.view addSubview:button5];
    
    UIButton *button6 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 250, 300, 200, 90)];
    [button6 setBackgroundImage:[UIImage imageNamed:@"easy_button.png"] forState:UIControlStateNormal];
    [button6 setTitle:@"Option 6" forState:UIControlStateNormal];
    [button6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button6.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:28.0]];
    [self.view addSubview:button6];
    

    SKNode *label1 = [SKNode new];
    label1.position = CGPointMake(150, self.frame.size.height - 345);
    label1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:button1.frame.size];
    label1.physicsBody.dynamic = NO;
    [self addChild:label1];
    
    SKNode *label2 = [SKNode new];
    label2.position = CGPointMake(200, self.frame.size.height - 545);
    label2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:button1.frame.size];
    label2.physicsBody.dynamic = NO;
    [self addChild:label2];
    
    SKNode *label3 = [SKNode new];
    label3.position = CGPointMake(250, self.frame.size.height - 745);
    label3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:button1.frame.size];
    label3.physicsBody.dynamic = NO;
    [self addChild:label3];
    
    SKNode *label4 = [SKNode new];
    label4.position = CGPointMake(self.frame.size.width - 250, self.frame.size.height - 745);
    label4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:button1.frame.size];
    label4.physicsBody.dynamic = NO;
    [self addChild:label4];
    
    SKNode *label5 = [SKNode new];
    label5.position = CGPointMake(self.frame.size.width - 200, self.frame.size.height - 545);
    label5.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:button1.frame.size];
    label5.physicsBody.dynamic = NO;
    [self addChild:label5];
    
    SKNode *label6 = [SKNode new];
    label6.position = CGPointMake(self.frame.size.width - 150, self.frame.size.height - 345);
    label6.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:button1.frame.size];
    label6.physicsBody.dynamic = NO;
    [self addChild:label6];
     

}

- (SKLabelNode *)newDancingTitle
{
    SKLabelNode *dancingTitle = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    
    // TODO: make more swoopy
    [dancingTitle setText:@"Welcome!"];
    dancingTitle.fontColor = [SKColor yellowColor];
    dancingTitle.fontSize = 72.0;
    
    SKAction *hover = [SKAction sequence:@[
                                           [SKAction moveByX:0.0 y:5.0 duration:0.3],
                                           [SKAction moveByX:0.0 y:-5.0 duration:0.3],
                                           [SKAction moveByX:0.0 y:5.0 duration:0.3],
                                           [SKAction moveByX:0.0 y:-5.0 duration:0.3],
                                           
                                           [SKAction moveByX:0.0 y:-15.0 duration:0.1],
                                           [SKAction moveByX:10.0 y:-10.0 duration:0.1],
                                           [SKAction moveByX:20.0 y:-5.0 duration:0.1],
                                           [SKAction moveByX:30 y:0.0 duration:0.1],
                                           [SKAction moveByX:20.0 y:5.0 duration:0.1],
                                           [SKAction moveByX:10.0 y:10.0 duration:0.1],
                                           [SKAction moveByX:0.0 y:15.0 duration:0.1],
                                           
                                           [SKAction moveByX:0.0 y:5.0 duration:0.3],
                                           [SKAction moveByX:0.0 y:-5.0 duration:0.3],
                                           [SKAction moveByX:0.0 y:5.0 duration:0.3],
                                           [SKAction moveByX:0.0 y:-5.0 duration:0.3],
                                           
                                           [SKAction moveByX:0.0 y:-15.0 duration:0.1],
                                           [SKAction moveByX:-10.0 y:-10.0 duration:0.1],
                                           [SKAction moveByX:-20.0 y:-5.0 duration:0.1],
                                           [SKAction moveByX:-30 y:0.0 duration:0.1],
                                           [SKAction moveByX:-20.0 y:5.0 duration:0.1],
                                           [SKAction moveByX:-10.0 y:10.0 duration:0.1],
                                           [SKAction moveByX:0.0 y:15.0 duration:0.1]
                                           
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

- (SKSpriteNode *)newSpaceship
{
    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor
                                                              darkGrayColor] size:CGSizeMake(64,32)];
    SKAction *hover = [SKAction sequence:@[
                                           [SKAction moveByX:0.0 y:5.0 duration:0.3],
                                           [SKAction moveByX:0.0 y:-5.0 duration:0.3],
                                           [SKAction moveByX:0.0 y:5.0 duration:0.3],
                                           [SKAction moveByX:0.0 y:-5.0 duration:0.3],
                                           [SKAction moveByX:300 y:0.0 duration:0.5],
                                           [SKAction moveByX:0.0 y:5.0 duration:0.3],
                                           [SKAction moveByX:0.0 y:-5.0 duration:0.3],
                                           [SKAction moveByX:0.0 y:5.0 duration:0.3],
                                           [SKAction moveByX:0.0 y:-5.0 duration:0.3],
                                           [SKAction moveByX:-300.0 y:0.0 duration:0.5]]];
    hover.timingMode = SKActionTimingEaseInEaseOut;
    [hull runAction: [SKAction repeatActionForever:hover]];
    
    // add light one, it goes counterclockwise
    SKSpriteNode *light1 = [self newLightForward:YES];
    light1.position = CGPointMake(25.0, 6.0);
    [hull addChild:light1];
    
    // add light two, it goes clockwise
    SKSpriteNode *light2 = [self newLightForward:NO];
    light2.position = CGPointMake(45.0, 6.0);
    [hull addChild:light2];
    
    // physics! science!
    hull.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hull.size];
    hull.physicsBody.dynamic = NO;
    
    return hull;
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
    
   
    /*
    // create a circular path around the ship
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, CGRectMake(-47.3,-22.3,50,50));
    SKAction *orbit = [SKAction followPath:circlePath duration:0.1];
    */
    
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
    } else {
        [light runAction:[SKAction repeatActionForever:[orbit reversedAction]]];
    }
    
    return light;
}


static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}

- (void) addRock
{
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[SKColor
                                                              whiteColor] size:CGSizeMake(4,4)];
    rock.position = CGPointMake(skRand(0, self.size.width),
                                self.size.height-50);
    rock.name = @"rock";
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection = NO;
    [self addChild:rock];
    
    // this is important for frame rate!
    [self performSelector:@selector(removeSnowFlake:) withObject:rock afterDelay:45.0];
    
}

- (void)removeSnowFlake:(SKNode *)snowFlake {
    
    [snowFlake removeFromParent];
    
}

-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node,
                                                           BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
}

// trying to make background snow

- (SKEmitterNode*) newSnowEmitter
{
    NSString *snowPath = [[NSBundle mainBundle] pathForResource:@"MyParticle"
                                                           ofType:@"sks"];
    SKEmitterNode *snow = [NSKeyedUnarchiver unarchiveObjectWithFile:snowPath];
    return snow;
}


@end
