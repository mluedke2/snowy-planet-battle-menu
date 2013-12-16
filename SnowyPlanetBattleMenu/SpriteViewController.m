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
@synthesize skView;

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
    [skView presentScene: scene];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
