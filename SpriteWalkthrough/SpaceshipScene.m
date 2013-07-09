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
    
    // add spaceship!
    SKSpriteNode *spaceship = [self newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame)-150,
                                     CGRectGetMidY(self.frame)-150);
    [self addChild:spaceship];
    
    //add rocks!
    SKAction *makeRocks = [SKAction sequence: @[
                                                [SKAction performSelector:@selector(addRock) onTarget:self],
                                                [SKAction waitForDuration:0.10 withRange:0.15]
                                                ]];
    [self runAction: [SKAction repeatActionForever:makeRocks]];
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
                                                               yellowColor] size:CGSizeMake(5,5)];
    
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
    
    // this makes an octagon, not a circle! but the elliptical CGPath doesn't seem to work yet
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
                                                              brownColor] size:CGSizeMake(8,8)];
    rock.position = CGPointMake(skRand(0, self.size.width),
                                self.size.height-50);
    rock.name = @"rock";
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:rock];
}


@end
