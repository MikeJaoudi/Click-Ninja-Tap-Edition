//
//  Firework.m
//  Click Ninja
//
//  Created by Michael Jaoudi on 7/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Firework.h"


@implementation Firework

-(id)init{
  
  
  [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
   @"Fireworks.plist"];
  self = [super initWithFile:@"Fireworks.png" capacity:150];
  // self = [[CCSpriteBatchNode batchNodeWithFile:@"Blue Fireworks_default.png"] retain];
  NSMutableArray *redFrames = [NSMutableArray array];
  for(int i = 1; i <= 56; ++i) {
    [redFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"Red Firework_%02d.png", i]]];
  }
  
  NSMutableArray *blueFrames = [NSMutableArray array];
  for(int i = 1; i <= 62; ++i) {
    [blueFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"Blue Firework_%02d.png", i]]];
  }
  
  NSMutableArray *greenFrames = [NSMutableArray array];
  for(int i = 1; i <= 49; ++i) {
    [greenFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"Green Firework_%02d.png", i]]];
  }
  
  fireworks = [[NSMutableArray alloc] init];
  
  redExplosion = [[CCAnimation alloc]  initWithSpriteFrames:redFrames delay:0.02f];
  blueExplosion = [[CCAnimation alloc]  initWithSpriteFrames:blueFrames delay:0.02f];
  greenExplosion = [[CCAnimation alloc]  initWithSpriteFrames:greenFrames delay:0.02f];
  
  for(int x=0;x<15;x++){
    CCSprite *sprite = [[CCSprite alloc] initWithSpriteFrameName:@"Blue Firework_01.png"];
    [fireworks addObject:sprite];
    [self addChild:sprite];
  }
  
  index = 0;
  
  return self;
}


-(void)fire{
  int rand = arc4random()%3;
  if(rand==0){
    [[fireworks objectAtIndex:index] runAction:[CCSpawn actions:[CCFadeIn actionWithDuration:0],[CCAnimate actionWithAnimation:redExplosion],[CCFadeOut actionWithDuration:1.0f], nil]];
  }
  else if(rand==1){
    [[fireworks objectAtIndex:index] runAction:[CCSpawn actions:[CCFadeIn actionWithDuration:0],[CCAnimate actionWithAnimation:blueExplosion],[CCFadeOut actionWithDuration:1.0f], nil]];
  }
  else if(rand==2){
    [[fireworks objectAtIndex:index] runAction:[CCSpawn actions:[CCFadeIn actionWithDuration:0],[CCAnimate actionWithAnimation:greenExplosion],[CCFadeOut actionWithDuration:1.0f], nil]];
  }
  double angle = floorf(((double)arc4random() / M_PI/4) - 0.2f);
  
  [[fireworks objectAtIndex:index] runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1.0f position:CGPointMake(200*cos(angle), 200*sin(angle))], [CCMoveTo actionWithDuration:0.0f position:CGPointMake(0,0)],nil]];
  index = (index+1)%[fireworks count];
  
}
@end
