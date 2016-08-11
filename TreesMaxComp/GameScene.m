//
//  GameScene.m
//  TreesMaxComp
//
//  Created by Mo DeJong on 8/10/16.
//  Copyright (c) 2016 HelpURock. All rights reserved.
//
// Performance results on iPad 4
//
// OpenGL mode: PrefersOpenGL=YES in Info.plist
//
// With 7 layers : 60 FPS
// With 8 layers : 50 FPS
// With 9 layers : 44 FPS
// With 10 layers: 39 FPS
//
// Metal mode: PrefersOpenGL=NO in Info.plist
//
// With 7 layers : 60 FPS
// With 8 layers : 57 FPS
// With 9 layers : 50 FPS
// With 10 layers: 46 FPS
//
// The Metal results are slightly better, but basically 8 layers of 2048x1536 (about 12 megs of pixels each layer)
// is the limit of what this iPad 4 64bit hardware can handle while still pushing 60 FPS.

#import "GameScene.h"

@interface GameScene ()

@property (nonatomic, retain) NSMutableArray *compLayers;

@end


@implementation GameScene

-(void)didMoveToView:(SKView *)view {
  
  CGSize backgroundSize = CGSizeMake(2048/2, 1536/2);
  
  SKSpriteNode *background = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:backgroundSize];
  
  background.texture = [SKTexture textureWithImageNamed:@"Background.png"];
  
  background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
  
  background.zPosition = 0;

  [self addChild:background];
  
  // Init max of 10 empty layers (does not consume memory)

  NSMutableArray *mArr = [NSMutableArray array];
  for ( int i = 0; i < 10; i++ ) {
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:backgroundSize];
    [mArr addObject:node];
  }
  self.compLayers = mArr;
}

//-(void)update:(CFTimeInterval)currentTime {}

-(void) setNumLayers:(int)numLayers {
  NSLog(@"setNumLayers %d", numLayers);
  
  int actualIndex = numLayers - 1;
  
  if (actualIndex >= 0) {
    SKSpriteNode *node = self.compLayers[actualIndex];
    
    if (node.texture == nil) {
      // Layer is not currently a child of root node
      
      NSString *resFilename = [NSString stringWithFormat:@"Comp%d.png", numLayers];
      
      node.texture = [SKTexture textureWithImageNamed:resFilename];
      
      NSAssert(node.texture, @"set texture for image \"%@\"", resFilename);
      
      node.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
      
      node.zPosition = numLayers;
      
      [self addChild:node];
      
      NSLog(@"added layer %@ at index %d", resFilename, actualIndex);
    }
  }
  
  for ( int i = numLayers; i < 10; i++ ) {
    SKSpriteNode *otherNode = self.compLayers[i];
    
    if (otherNode.texture != nil) {
      NSLog(@"removed layer at index %d", i);
      otherNode.texture = nil;
      [otherNode removeFromParent];
    }
  }
  
  return;
}

@end
