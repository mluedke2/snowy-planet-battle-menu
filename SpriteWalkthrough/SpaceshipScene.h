//
//  SpaceshipScene.h
//  SpriteWalkthrough
//
//  Created by Matt Luedke on 7/9/13.
//  Copyright (c) 2013 Matt Luedke. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SpaceshipScene : SKScene {
    CALayer *_animationLayer;
    CAShapeLayer *_pathLayer;
    CALayer *_penLayer;
}

@property BOOL contentCreated;

@property (nonatomic, retain) CALayer *animationLayer;
@property (nonatomic, retain) CAShapeLayer *pathLayer;
@property (nonatomic, retain) CALayer *penLayer;

@end
