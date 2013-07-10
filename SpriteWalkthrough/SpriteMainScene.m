//
//  SpriteMainScene.m
//  SpriteWalkthrough
//
//  Created by Matt Luedke on 7/10/13.
//  Copyright (c) 2013 Matt Luedke. All rights reserved.
//

#import "SpriteMainScene.h"

@implementation SpriteMainScene

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
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    [self addChild: [self newEndingNode]];
}

- (SKLabelNode*)newEndingNode
{
    SKLabelNode *endingNode = [SKLabelNode
                              labelNodeWithFontNamed:@"Helvetica"];
    endingNode.text = @"The End";
    endingNode.fontSize = 42;
    endingNode.position =
    CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    endingNode.name = @"endingNode";
    return endingNode;
}

@end
