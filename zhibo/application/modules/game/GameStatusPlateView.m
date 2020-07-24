//
//  GameStatusPlateView.m
//  zhibo
//
//  Created by qp on 2020/7/1.
//  Copyright © 2020 qp. All rights reserved.
//

#import "GameStatusPlateView.h"
@interface GameStatusPlateView ()
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
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFrequency) userInfo:nil repeats:true];
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

- (void)dealloc {
    [self.timer invalidate];
}

@end
