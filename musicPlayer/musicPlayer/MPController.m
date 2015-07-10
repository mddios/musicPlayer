//
//  MPController.m
//  musicPlayer
//
//  Created by coohua on 15/7/10.
//  Copyright (c) 2015年 cn.coohua. All rights reserved.
//

#import "MPController.h"

#import <AVFoundation/AVFoundation.h>
@interface MPController ()
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSTimer *audioTimer;
@end

@implementation MPController


/// 提供一个单例
+ (instancetype)sharedMP {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (instancetype)init {
    if (self = [super init]) {
        [self setUpAudioSession];
        
        // 播放文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"梁静茹 - 温柔" ofType:@"mp3"];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:filePath];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        [self.audioPlayer prepareToPlay];
        // 0.0~1.0,默认为1.0
        self.audioPlayer.volume = 1.0;
        // 播放一次
        self.audioPlayer.numberOfLoops = 0;
    }
    return self;
}


- (void)startAudioPlay {
    // 异步执行
    [self.audioPlayer play];
}
- (void)stopAudioPlay {
    [self.audioPlayer stop];
}
- (void)setUpAudioSession {
    // 新建AudioSession会话
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    // 设置后台播放
    NSError *error = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&error];
    
    if (error) {
        NSLog(@"Error setCategory AVAudioSession: %@", error);
    }
    
    NSError *activeSetError = nil;
    // 启动AudioSession，如果一个前台app正在播放音频则可能启动失败
    [audioSession setActive:YES error:&activeSetError];
    if (activeSetError) {
        NSLog(@"Error activating AVAudioSession: %@", activeSetError);
    }
}

@end
