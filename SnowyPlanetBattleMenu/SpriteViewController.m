//
//  SpriteViewController.m
//  SpriteWalkthrough
//
//  Created by Matt Luedke on 7/9/13.
//  Copyright (c) 2013 Matt Luedke. All rights reserved.
//

#import "SpriteViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "MenuScene.h"

@interface SpriteViewController ()

@end

@implementation SpriteViewController
@synthesize skView, button1, button2, button3, button4, button5, button6;

/*
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
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    skView.showsDrawCount = YES;
    skView.showsNodeCount = YES;
    skView.showsFPS = YES;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    
    MenuScene *scene = [[MenuScene alloc]
                         initWithSize:self.view.frame.size];
    scene.button1 = button1;
    scene.button2 = button2;
    scene.button3 = button3;
    scene.button4 = button4;
    scene.button5 = button5;
    scene.button6 = button6;
    
    [skView presentScene: scene];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
