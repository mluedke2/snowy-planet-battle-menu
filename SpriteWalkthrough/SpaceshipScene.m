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
    self.backgroundColor = [SKColor lightGrayColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    SKSpriteNode *spaceship = [self newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame)-150,
                                     CGRectGetMidY(self.frame)-150);
    [self addChild:spaceship];
}

- (SKSpriteNode *)newSpaceship
{
    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor
                                                              blueColor] size:CGSizeMake(64,32)];
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
    
    SKSpriteNode *light1 = [self newLightForward:YES];
    light1.position = CGPointMake(25.0, 6.0);
    [hull addChild:light1];
    SKSpriteNode *light2 = [self newLightForward:NO];
    light2.position = CGPointMake(45.0, 6.0);
    [hull addChild:light2];
    
    return hull;
}

- (SKSpriteNode *)newLightForward:(BOOL)forward
{
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor
                                                               yellowColor] size:CGSizeMake(5,5)];
  
    /*
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithImageNamed:@"stat_happy"];
    [light setSize:CGSizeMake(30, 30)];
    light.color = [SKColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    light.colorBlendFactor = 1.0;
    */
    
    
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

@end
