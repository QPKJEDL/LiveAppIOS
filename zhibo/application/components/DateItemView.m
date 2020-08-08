//
//  DateItemView.m
//  zhibo
//
//  Created by qp on 2020/8/5.
//  Copyright © 2020 qp. All rights reserved.
//

#import "DateItemView.h"
#import "GFCalendarView.h"
@interface DateItemView ()
@end
@implementation DateItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dateButton = [[QMUIButton alloc] initWithFrame:CGRectMake(15, 0, 120, 44)];
        self.dateButton.titleLabel.font = [UIFont PingFangSC:14];
        [self.dateButton setTitleColor:[UIColor hexColor:@"#A8A8A8"] forState:UIControlStateNormal];
        [self addSubview:self.dateButton];
        [self.dateButton addTarget:self action:@selector(onDateButton) forControlEvents:UIControlEventTouchUpInside];
        self.dateButton.spacingBetweenImageAndTitle = 18;
        self.dateButton.imagePosition = QMUIButtonImagePositionRight;
        [self.dateButton setImage:[UIImage imageNamed:@"form_arrow_down"] forState:UIControlStateNormal];
        [self.dateButton setImage:[UIImage imageNamed:@"form_arrow_up"] forState:UIControlStateSelected];
        [self.dateButton setTitle:[ABTime timestampToTime:[ABTime timestamp] format:@"Y-MM-dd"] forState:UIControlStateNormal];
        
        
        self.selectButton = [[QMUIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-44, 17, 44, 22)];
        self.selectButton.titleLabel.font = [UIFont PingFangSC:14];
        [self.selectButton setTitleColor:[UIColor hexColor:@"#A8A8A8"] forState:UIControlStateNormal];
        [self addSubview:self.selectButton];
        [self.selectButton setTitle:@"查询" forState:UIControlStateNormal];
        self.selectButton.layer.borderWidth = 1;
        self.selectButton.layer.cornerRadius = 4;
        self.selectButton.clipsToBounds = true;
        self.selectButton.layer.borderColor = [UIColor hexColor:@"#A8A8A8"].CGColor;
        self.selectButton.centerY = self.height/2;
    }
    return self;
}

- (void)onDateButton {
    GFCalendarView *calendarView = [[GFCalendarView alloc] initWithFrameOrigin:CGPointMake(15, 0) width:SCREEN_WIDTH-2*15];
    calendarView.backgroundColor = [UIColor whiteColor];
    calendarView.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
        NSLog(@"=====%zd=====%zd=====%zd", year, month, day);
        NSString *newDateStr = [NSString stringWithFormat:@"%zd-%02ld-%02ld", year, (long)month, (long)day];
        [self.dateButton setTitle:newDateStr forState:UIControlStateNormal];
        [[ABUIPopUp shared] remove];
    };
    [[ABUIPopUp shared] show:calendarView from:ABPopUpDirectionCenter];
    
}

@end
