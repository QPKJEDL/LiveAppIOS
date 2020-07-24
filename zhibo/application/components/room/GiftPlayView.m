//
//  GiftPlayView.m
//  zhibo
//
//  Created by qp on 2020/7/13.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GiftEffectsPlayView.h"
#import <AVFoundation/AVFoundation.h>
@import TXLiteAVSDK_Smart;
@interface GiftEffectsPlayView ()<TXLivePlayListener>
@property (nonatomic, strong) TXLivePlayer *player;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
//@property (nonatomic, strong) AVPlayer *player;
//@property (nonatomic, strong) AVPlayerLayer *layer;
@end
@implementation GiftEffectsPlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.containView = [[UIView alloc] initWithFrame:self.bounds];
        self.containView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.containView];
        
        _player = [[TXLivePlayer alloc] init];
        [_player setRenderMode:RENDER_MODE_FILL_EDGE];
        _player.enableHWAcceleration = true;
        _player.delegate = self;
        [_player setupVideoWidget:self.bounds containView:self.containView insertIndex:0];
        
    }
    return self;
}

- (void)show {
    if (self.superview != nil) {
        return;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1_720.mp4" ofType:nil];
    [self.player startPlay:path type:PLAY_TYPE_VOD_MP4];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

@end
