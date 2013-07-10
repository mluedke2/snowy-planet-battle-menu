//
//  SpriteMainScene.m
//  SpriteWalkthrough
//
//  Created by Matt Luedke on 7/10/13.
//  Copyright (c) 2013 Matt Luedke. All rights reserved.
//

#import "SpriteMainScene.h"
#import "MenuScene.h"

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

- (void)touchesBegan:(NSSet*) touches withEvent:(UIEvent *)event
{
    SKNode *endingNode = [self childNodeWithName:@"endingNode"];
    if (endingNode != nil)
    {
        endingNode.name = nil;
       
            SKScene *menuScene = [[MenuScene alloc]
                                       initWithSize:self.size];
            SKTransition *doors = [SKTransition
                                   doorsOpenHorizontalWithDuration:0.5];
            [self.view presentScene:menuScene transition:doors];
        
    }
}


@end
