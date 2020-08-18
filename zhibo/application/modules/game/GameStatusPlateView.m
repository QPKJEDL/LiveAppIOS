//
//  GameStatusPlateView.m
//  zhibo
//
//  Created by qp on 2020/7/1.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameStatusPlateView.h"
@interface GameStatusPlateView ()<IABMQSubscribe>
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) NSTimeInterval endTime;

@property (nonatomic, assign) NSInteger timeOffset;
@end
@implementation GameStatusPlateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height-20, self.width, 20)];
        self.timeLabel.font = [UIFont boldSystemFontOfSize:20];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.timeLabel];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height-20, self.width, 20)];
        self.textLabel.font = [UIFont boldSystemFontOfSize:12];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.textLabel];
        
        
        self.layer.borderWidth = 2;
        self.layer.shadowOpacity = 0.58;
        
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 5;
        
//        [[ABMQ shared] subscribe:self channel:CHANNEL_GAME_STATUS autoAck:true];
    }
    return self;
}

- (void)please:(NSDictionary *)info {
    
    NSInteger countDown = [info[@"CountDown"] integerValue];
    NSInteger Systime = [info[@"Systime"] integerValue];
    NSInteger gameStrTime = [info[@"GameStarTime"] integerValue];
    
    
    
    [[ABAudio shared] playBundleFileWithName:@"starBet.mp3"];
    self.textLabel.text = @"请下注";
    self.textLabel.top = self.height/2-20;
    self.timeLabel.top = self.height/2;
    self.textLabel.textColor = [UIColor hexColor:@"#26E2DE"];
    self.timeLabel.textColor = [UIColor hexColor:@"#26E2DE"];
    self.layer.borderColor = [UIColor hexColor:@"26E2DE"].CGColor;
    self.layer.shadowColor = [UIColor hexColor:@"26E2DE"].CGColor;

    self.startTime = Systime;
    self.endTime = gameStrTime+countDown;
   
    if (self.timer) {
        [self.timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[ABWeakProxy proxyWithTarget:self] selector:@selector(timerFrequency) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [self refreshDown];
}

- (void)refreshDown {
    NSInteger offset = self.endTime-self.startTime;
    self.timeLabel.text = [NSString stringWithFormat:@"%lds", (long)offset];
    if (offset <= 0) {
        [[ABAudio shared] playBundleFileWithName:@"stopBet.mp3"];
        [self.timer invalidate];
        [self wait];
    }
    else if (offset == 10) {
        [[ABAudio shared] playBundleFileWithName:@"lastTenM.mp3"];
    }
    else if (offset <= 5) {
        [[ABAudio shared] playBundleFileWithName:@"count_down.mp3"];
    }
    
    self.startTime++;
}

- (void)timerFrequency {
    [self refreshDown];
}

- (void)finish {
    self.textLabel.text = @"已完结";
    self.timeLabel.text = @"";
    self.textLabel.textColor = [UIColor hexColor:@"#FFC71C"];
    self.textLabel.centerY = self.height/2;
    
    self.layer.borderColor = [[UIColor hexColor:@"FFC71C"] colorWithAlphaComponent:0.58].CGColor;
    self.layer.shadowColor = [[UIColor hexColor:@"FFC71C"] colorWithAlphaComponent:0.58].CGColor;
}

- (void)wait {
    if ([self.timer isValid]) {
        [[ABAudio shared] playBundleFileWithName:@"stopBet.mp3"];
        [self.timer invalidate];
    }
    
    self.textLabel.text = @"待开牌";
    self.timeLabel.text = @"";
    self.textLabel.textColor = [UIColor hexColor:@"#E62020"];
    self.textLabel.centerY = self.height/2;
    
    self.layer.borderColor = [[UIColor hexColor:@"E62020"] colorWithAlphaComponent:0.58].CGColor;
    self.layer.shadowColor = [[UIColor hexColor:@"E62020"] colorWithAlphaComponent:0.58].CGColor;
    
    [self.delegate plateView:self onStatusChanged:GameStatusPlateViewStatusWait];
}

- (void)watch {
    self.textLabel.text = @"洗牌中";
    self.timeLabel.text = @"";
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.centerY = self.height/2;
    
    self.layer.borderColor = [[UIColor hexColor:@"ffffff"] colorWithAlphaComponent:0.58].CGColor;
    self.layer.shadowColor = [[UIColor hexColor:@"ffffff"] colorWithAlphaComponent:0.58].CGColor;
}

//- (void)abmq:(ABMQ *)abmq onReceiveMessage:(id)message channel:(NSString *)channel {
//    NSDictionary *dic = (NSDictionary *)message;
//    NSInteger status = [dic[@"status"] integerValue];
//    NSDictionary *data = (NSDictionary *)message[@"data"];
//    switch (status) {
//        case 0: //洗牌中
//            [self watch]; //变更洗牌中
//            break;
//        case 1://开始下注
//            [self please:data]; //开启下注倒计时
//            break;
//        case 2://开牌中(停止下注)
//            [self wait]; //变更待开牌
//
//            break;
//        case 3://结算完成
//            [self finish];
//            break;
//        case 4://结算完成(有结果)
//            [self finish];
//            break;
//        default:
//            break;
//    }
//}

- (void)stop {
    [self.timer invalidate];
}

- (void)dealloc {
    [self.timer invalidate];
}

@end
