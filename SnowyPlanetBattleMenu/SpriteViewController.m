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
#import "NextViewController.h"

@interface SpriteViewController ()

@end

@implementation SpriteViewController
@synthesize skView, button1, button2, button3, button4, button5, button6;

//- (void)buttonChoice:(UIButton *)sender {
//    [menuScene buttonChoice:sender];
//}

- (void)buttonChoice:(UIButton *)sender {
    
    SKNode *dancingTitle = [menuScene childNodeWithName:@"dancingTitle"];
    
    CGPoint buttonCenter = CGPointMake(CGRectGetMidX(sender.frame), self.skView.frame.size.height - CGRectGetMidY(sender.frame));
    
    SKAction *shootLightAndDisappear = [SKAction sequence:@[
                                                            [SKAction fadeAlphaTo:1.0 duration:0.2],
                                                            [SKAction scaleBy:4.0 duration:1.0],
                                                            [SKAction moveTo:[menuScene convertPoint:buttonCenter toNode:dancingTitle] duration:0.5],
                                                            [SKAction removeFromParent]
                                                            ]];
    
    SKNode *light1 = [dancingTitle childNodeWithName:@"light1"];
    SKNode *light2 = [dancingTitle childNodeWithName:@"light2"];
    
    // stop all animations; we need all the frame rate we can get for this!!
    [light1 removeAllActions];
    [light2 removeAllActions];
    [menuScene removeAllActions];
    [dancingTitle removeAllActions];
    
    [light1 runAction:shootLightAndDisappear];
    [light2 runAction:shootLightAndDisappear completion:^{
        
        // insert 'splosion!
        sender.hidden = YES;
        SKEmitterNode *splosion = [menuScene newSplosion];
        splosion.particlePosition = buttonCenter;
        [menuScene addChild:splosion];
        
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
                     
                     NextViewController *nextViewController = [[NextViewController alloc] initWithNibName:@"NextViewController" bundle:nil];
                     
                     [self presentViewController:nextViewController animated:YES completion:nil];
                     
                     //                     // and... scene!
                     //                     [[self.view subviews]
                     //                      makeObjectsPerformSelector:@selector(removeFromSuperview)];
                     //
                     //                     SKScene* endScene = [[SpriteEndScene alloc]
                     //                                           initWithSize:self.size];
                     //                     SKTransition *doors = [SKTransition
                     //                                            doorsCloseHorizontalWithDuration:0.5];
                     //                     [self.view presentScene:endScene transition:doors];
                     
                 }];
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    skView.showsDrawCount = YES;
    skView.showsNodeCount = YES;
    skView.showsFPS = YES;
    
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    skView.paused = YES;
}

- (void) viewWillAppear:(BOOL)animated {
    
    menuScene = [[MenuScene alloc]
                         initWithSize:self.view.frame.size];
    menuScene.button1 = button1;
    menuScene.button2 = button2;
    menuScene.button3 = button3;
    menuScene.button4 = button4;
    menuScene.button5 = button5;
    menuScene.button6 = button6;
    
    button1.hidden = NO;
    button2.hidden = NO;
    button3.hidden = NO;
    button4.hidden = NO;
    button5.hidden = NO;
    button6.hidden = NO;
    
    [skView presentScene: menuScene];
    
    skView.paused = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
