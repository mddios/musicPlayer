//
//  MusicViewController.m
//  musicPlayer
//
//  Created by coohua on 15/7/21.
//  Copyright (c) 2015年 cn.coohua. All rights reserved.
//

#import "MusicViewController.h"
#import "MPController.h"
#import <Masonry.h>

@interface MusicViewController ()

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addSubviews];
}
- (void)addSubviews {
    UIImage *img = [UIImage imageNamed:@"AudioPlayerNoArtwork"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = self.view.bounds;
    [self.view addSubview:imgView];
//    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).with.offset(64);
//        make.leading.equalTo(self.view);
//        make.trailing.equalTo(self.view);
//        make.height.equalTo(@(img.size.height));
//    }];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [[MPController sharedMP] startAudioPlay];
}

// 停止播放
- (void)viewDidDisappear:(BOOL)animated {
    [[MPController sharedMP] stopAudioPlay];
}
@end
