//
//  GiftPlayView.m
//  zhibo
//
//  Created by qp on 2020/7/13.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GiftEffectsPlayView.h"
#import <AVFoundation/AVFoundation.h>
#import <TSHAlphaVideos/TSHAlphaVideoController.h>
@interface GiftEffectsPlayView ()<TSHAlphaVideoDelegate>
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) TSHAlphaVideoController *myAwesomeVideo;
//@property (nonatomic, strong) AVPlayer *player;
//@property (nonatomic, strong) AVPlayerLayer *layer;
@end
@implementation GiftEffectsPlayView
+ (GiftEffectsPlayView *)shared {
    static GiftEffectsPlayView *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[GiftEffectsPlayView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.containView = [[UIView alloc] initWithFrame:self.bounds];
        self.containView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.containView];
        
    }
    return self;
}

- (void)showWithVideoFile:(NSString *)fileName {
    if (self.superview == nil) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    _myAwesomeVideo = [TSHAlphaVideoController videoWithRGBVideoFile:@"1_720" withDelegate:self];
    [self addSubview:_myAwesomeVideo.view];
    [_myAwesomeVideo play];
}

- (void)alphaVideoWillPlay:(TSHAlphaVideoController *)alphaVideo {
    
}
- (void)alphaVideoDidPlay:(TSHAlphaVideoController *)alphaVideo {
    
}

- (void)alphaVideo:(TSHAlphaVideoController *)alphaVideo
didPlayFrameAtTimeInterval:(NSTimeInterval)timeInterval
      previousTimeInterval:(NSTimeInterval)previousTimeInterval {
    
}

- (void)alphaVideoWillStop:(TSHAlphaVideoController *)alphaVideo {
    
}
- (void)alphaVideoDidStop:(TSHAlphaVideoController *)alphaVideo {
    [self.myAwesomeVideo.view removeFromSuperview];
    [self removeFromSuperview];
}

- (void)memoryWarningStoppedVideo:(TSHAlphaVideoController *)alphaVideo {
    
}
@end
