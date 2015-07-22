//
//  MusicViewController.m
//  musicPlayer
//
//  Created by coohua on 15/7/21.
//  Copyright (c) 2015年 cn.coohua. All rights reserved.
//

#import "MusicViewController.h"
#import "MPController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <Masonry.h>

@interface MusicViewController ()
@property (nonatomic, weak) UIButton *btn;
@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addSubviews];
    [[MPController sharedMP] startAudioPlay];
    [self lockScreen];
}
- (void)addSubviews {
    UIImage *img = [UIImage imageNamed:@"AudioPlayerNoArtwork"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
//    imgView.frame = self.view.bounds;
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
//        make.height.equalTo(self.view).with.bottom.offset(44);
        make.bottom.equalTo(self.view).with.offset(-44);
    }];
    // 添加按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"AudioPlayerPause"] forState:UIControlStateNormal];
    // 1代表播放
//    btn.tag = 1;
    btn.selected = YES;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-7);
        make.centerX.equalTo(self.view);
    }];
    [btn addTarget:self action:@selector(didClickedPlayPauseBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.btn = btn;
}
- (void)didClickedPlayPauseBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [[MPController sharedMP] startAudioPlay];
        [self.btn setImage:[UIImage imageNamed:@"AudioPlayerPause"] forState:UIControlStateNormal];
    } else {
        [[MPController sharedMP] stopAudioPlay];
        [self.btn setImage:[UIImage imageNamed:@"AudioPlayerPlay"] forState:UIControlStateNormal];
    }
}
- (void)lockScreen {
    NSArray *keys = [NSArray arrayWithObjects:
                     MPMediaItemPropertyTitle,
                     MPMediaItemPropertyArtist,
                     MPMediaItemPropertyPlaybackDuration,
                     MPNowPlayingInfoPropertyPlaybackRate,
                     MPMediaItemPropertyArtwork,
                     MPMediaItemPropertyAlbumTitle,
                     nil];
    /// 图片
    UIImage *artwork = [UIImage imageNamed:@"QQ20150708-1"];
    MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:artwork];
    
    NSArray *values = @[@"歌曲名字-iOS",
                        @"歌曲演唱者-dengdeng",
                        @(128),
                        @1,
                        albumArt,
                        @"歌曲专辑-coohua"];
    NSMutableDictionary *mediaInfo = [NSMutableDictionary dictionaryWithObjects:values forKeys:keys];
    
    mediaInfo[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"QQ20150708-1"]];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:mediaInfo];
    
    [self controlCenter];
}
- (void)controlCenter {
    MPRemoteCommandCenter *rcc = [MPRemoteCommandCenter sharedCommandCenter];
    
    // 下一首歌的按钮
    MPRemoteCommand *nextTrackCommand = [rcc nextTrackCommand];
    [nextTrackCommand setEnabled:YES];
    [nextTrackCommand addTarget:self action:@selector(skipBackwardEvent:)];
    
    // 暂停按钮
    MPRemoteCommand *pauseCommand = [rcc pauseCommand];
    [pauseCommand setEnabled:YES];
    [pauseCommand addTarget:self action:@selector(playOrPauseEvent)];
    //
    MPRemoteCommand *playCommand = [rcc playCommand];
    [playCommand setEnabled:YES];
    [playCommand addTarget:self action:@selector(playOrPauseEvent)];
    
    
    // feedback,控制中心
    MPRemoteCommand *likeCommand = [rcc likeCommand];
    [rcc setValue:@"\ue415哈哈" forKeyPath:@"likeCommand.localizedTitle"];
    [likeCommand setEnabled:YES];
    [likeCommand addTarget:self action:@selector(playOrPauseEvent)];
    
    MPRemoteCommand *dislikeCommand = [rcc dislikeCommand];
    [rcc setValue:@"\ue415嘻嘻" forKeyPath:@"dislikeCommand.localizedTitle"];
    [dislikeCommand setEnabled:YES];
    [dislikeCommand addTarget:self action:@selector(playOrPauseEvent)];
    
    MPRemoteCommand *bookmarkCommand = [rcc bookmarkCommand];
    [rcc setValue:@"\ue415呵呵" forKeyPath:@"bookmarkCommand.localizedTitle"];
    [bookmarkCommand setEnabled:YES];
    [bookmarkCommand addTarget:self action:@selector(playOrPauseEvent)];
    
}
- (void)playOrPauseEvent {
    MPRemoteCommandCenter *rcc = [MPRemoteCommandCenter sharedCommandCenter];
    if (rcc.pauseCommand.enabled) {
        rcc.pauseCommand.enabled = NO;
        rcc.playCommand.enabled = YES;
    } else {
        rcc.pauseCommand.enabled = YES;
        rcc.playCommand.enabled = NO;
    }
    NSLog(@"pasue-play");
}
-(void)skipBackwardEvent: (MPRemoteCommand *)nextTrackCommand
{
    NSLog(@"Skip backward by %@", nextTrackCommand);
}

//- (void)viewDidAppear:(BOOL)animated {
//    [[MPController sharedMP] startAudioPlay];
//}
//
//// 停止播放
//- (void)viewDidDisappear:(BOOL)animated {
//    [[MPController sharedMP] stopAudioPlay];
//}
@end
