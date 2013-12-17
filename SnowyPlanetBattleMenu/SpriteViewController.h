//
//  SpriteViewController.h
//  SpriteWalkthrough
//
//  Created by Matt Luedke on 7/9/13.
//  Copyright (c) 2013 Matt Luedke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "MenuScene.h"

@interface SpriteViewController : UIViewController {
    
    MenuScene *menuScene;
    IBOutlet SKView *skView;
}

@property (nonatomic, retain) IBOutlet SKView *skView;

@property (nonatomic, retain) IBOutlet UIButton *button1;
@property (nonatomic, retain) IBOutlet UIButton *button2;
@property (nonatomic, retain) IBOutlet UIButton *button3;
@property (nonatomic, retain) IBOutlet UIButton *button4;
@property (nonatomic, retain) IBOutlet UIButton *button5;
@property (nonatomic, retain) IBOutlet UIButton *button6;

-(IBAction)buttonChoice:(UIButton *)sender;

@end
