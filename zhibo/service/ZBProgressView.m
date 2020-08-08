//
//  ZBProgressView.m
//  zhibo
//
//  Created by qp on 2020/8/3.
//  Copyright © 2020 qp. All rights reserved.
//

#import "ZBProgressView.h"
@interface ZBProgressView ()
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *cursorView;
@property (nonatomic, strong) UILabel *cursorLabel;

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end
@implementation ZBProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        self.mainView = [[UIView alloc] initWithFrame:self.bounds];
        self.mainView.backgroundColor = [UIColor hexColor:@"#DADEE9"];
        self.mainView.layer.cornerRadius = self.height/2;
        self.mainView.clipsToBounds = true;
        [self addSubview:self.mainView];
        
        self.cursorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.height)];
        self.cursorView.layer.cornerRadius = self.height/2;
        self.cursorView.backgroundColor = [UIColor hexColor:@"#FF2860"];
        [self.mainView addSubview:self.cursorView];
        
        self.cursorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, self.height)];
        self.cursorLabel.textAlignment = NSTextAlignmentRight;
        self.cursorLabel.font = [UIFont PingFangSC:14];
        self.cursorLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.cursorLabel];
        
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height, 40, 20)];
        self.leftLabel.text = @"0";
        self.leftLabel.font = [UIFont PingFangSC:14];
        self.leftLabel.textColor = [UIColor hexColor:@"#474747"];
        [self addSubview:self.leftLabel];
        
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-40, self.height, 40, 20)];
        self.rightLabel.text = @"100";
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        self.rightLabel.font = [UIFont PingFangSC:14];
        self.rightLabel.textColor = [UIColor hexColor:@"#474747"];
        [self addSubview:self.rightLabel];
        
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.cursorView.width = self.mainView.width*progress;
    self.cursorView.left = 0;
    
    self.cursorLabel.left = self.cursorView.width-self.cursorLabel.width-5;
    
    NSString *text = [NSString stringWithFormat:@"%.0f", progress*100];
    self.cursorLabel.text = text;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self refresh:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self refresh:touches];
}

- (void)refresh:(NSSet<UITouch *> *)touches {
    CGPoint p = [[touches anyObject] locationInView:self];
    if (p.x < 0) {
        return;
    }
    
    self.progress = p.x/self.width;
    if (self.progress > 1) {
        self.progress = 1;
    }
    
    
}

@end
