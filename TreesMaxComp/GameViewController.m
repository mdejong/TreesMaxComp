//
//  GameViewController.m
//  TreesMaxComp
//
//  Created by Mo DeJong on 8/10/16.
//  Copyright (c) 2016 HelpURock. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@interface GameViewController ()

@property (nonatomic, retain) IBOutlet UIStepper *stepper;

@property (nonatomic, retain) IBOutlet UILabel *numLayersLabel;

@property (nonatomic, assign) int numLayers;

@property (nonatomic, retain) GameScene *selfScene;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    NSAssert(self.stepper, @"stepper");
    NSAssert(self.numLayersLabel, @"numLayersLabel");

    self.stepper.maximumValue = 10;

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    skView.opaque = TRUE;
    
    // Create and configure the scene.
    GameScene *scene = [GameScene nodeWithFileNamed:@"GameScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
  
    self.selfScene = scene;
  
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)stepperValueChanged:(UIStepper *)sender
{
  NSUInteger value = self.stepper.value;
  self.numLayers = (int) value;
  self.numLayersLabel.text = [NSString stringWithFormat:@"%2d", (int)value];
  [self.selfScene setNumLayers:(int)value];
  return;
}

@end
