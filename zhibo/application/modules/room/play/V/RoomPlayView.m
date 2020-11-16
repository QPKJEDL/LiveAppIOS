//
//  RoomPlayView.m
//  zhibo
//
//  Created by qp on 2020/7/10.
//  Copyright © 2020 qp. All rights reserved.
//

#import "RoomPlayView.h"
@import TXLiteAVSDK_Smart;
@interface RoomPlayView ()<TXLivePlayListener>
@property (nonatomic, strong) TXLivePlayer *player;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end
@implementation RoomPlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [UIColor hexColor:@"161823"];
        [self addSubview:self.backgroundView];
        
        self.containView = [[UIView alloc] initWithFrame:self.bounds];
        self.containView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.containView];
        
        _player = [[TXLivePlayer alloc] init];
        [_player setRenderMode:RENDER_MODE_FILL_SCREEN];
        _player.enableHWAcceleration = true;
        _player.delegate = self;
        [_player setupVideoWidget:self.bounds containView:self.containView insertIndex:0];
//        [_player startPlay:@"http://111.13.111.242/otttv.bj.chinamobile.com/PLTV/88888888/224/3221226226/1.m3u8" type:PLAY_TYPE_VOD_HLS];
        
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:self.bounds];
        self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [self addSubview:self.indicatorView];
        
        [self startListenAppStatus];
        

        
    }
    return self;
}

- (void)startListenAppStatus {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)applicationDidEnterBackground {
    NSLog(@"applicationDidEnterBackground");
    [self.player pause];
}

- (void)applicationDidBecomeActive {
    NSLog(@"applicationDidBecomeActive");
    [self.player resume];
}

- (void)playURL:(NSString *)url {
    [self.indicatorView startAnimating];
    self.currentURL = url;
    self.player.delegate = self;
    if ([url hasPrefix:@"rtmp"]) {
        [_player startPlay:url type:PLAY_TYPE_LIVE_RTMP];
    }else {
        [_player setRenderMode:RENDER_MODE_FILL_EDGE];
        [_player startPlay:url type:PLAY_TYPE_VOD_HLS];
    }
}

- (void)viewWillAppear {
   
    if (self.containView.subviews.count == 0) {
        return;
    }
    [self.containView.subviews[0] setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDisAppear {
    
}

#pragma mark -------------  player delegate -----------
- (void)onPlayEvent:(int)EvtID withParam:(NSDictionary *)param {
//    NSLog(@"%i", EvtID);
    if (EvtID == PLAY_EVT_PLAY_BEGIN || EvtID == PLAY_EVT_RTMP_STREAM_BEGIN) {
        [self.containView.subviews[0] setBackgroundColor:[UIColor clearColor]];
        [self.indicatorView stopAnimating];
    }
    else if (EvtID == PLAY_ERR_NET_DISCONNECT) {
        NSLog(@"播放失败");
        [self.indicatorView stopAnimating];
        [ABUITips showError:self.erNotice];
        if (self.delegate && [self.delegate respondsToSelector:@selector(roomPlayViewLoadFail)]) {
            [self.delegate roomPlayViewLoadFail];
        }
    }
//    if (EvtID == PLAY_EVT_PLAY_BEGIN) {
//        stopLoadingAnimation();
//    }
//    else if (event == TXLiveConstants.PLAY_ERR_NET_DISCONNECT) {
//        stopPlayRtmp();
//    else if (EvtID == PLAY_EVT_PLAY_END) {
//        NSLog(@"直播已结束");
//    }
//else if (event == TXLiveConstants.PLAY_EVT_PLAY_LOADING){
//        startLoadingAnimation();
//    }
//    String msg = param.getString(TXLiveConstants.EVT_DESCRIPTION);
//    appendEventLog(event, msg);
//    if (event < 0) {
//            Toast.makeText(this, param.getString(TXLiveConstants.EVT_DESCRIPTION), Toast.LENGTH_SHORT).show();
//    }
//    else if (event == TXLiveConstants.PLAY_EVT_PLAY_BEGIN) {
//        stopLoadingAnimation();
//    }
}


- (void)onNetStatus:(NSDictionary *)param {
    
}

- (void)remove {
    [self.player stopPlay];
    self.player.delegate = nil;
}

- (void)free {
    if ([self.player stopPlay]) {
        NSLog(@"player stop success");
    }
    
    [self.player setDelegate:nil];
    [self.player removeVideoWidget];
    self.player = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    [_player setupVideoWidget:self.bounds containView:self insertIndex:0];
}

- (void)dealloc {
//    [self.player stopPlay];
    NSLog(@"%@ dealloc", [[self class] description]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

