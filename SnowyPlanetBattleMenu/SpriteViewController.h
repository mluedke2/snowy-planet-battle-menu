//
//  SpriteViewController.h
//  SpriteWalkthrough
//
//  Created by Matt Luedke on 7/9/13.
//  Copyright (c) 2013 Matt Luedke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface SpriteViewController : UIViewController {
    
    IBOutlet SKView *skView;
}

@property (nonatomic, retain) IBOutlet SKView *skView;

@end
