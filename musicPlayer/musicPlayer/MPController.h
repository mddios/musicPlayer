//
//  MPController.h
//  musicPlayer
//
//  Created by coohua on 15/7/10.
//  Copyright (c) 2015年 cn.coohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPController : NSObject
+ (instancetype)sharedMP;
- (void)startAudioPlay;
@end
