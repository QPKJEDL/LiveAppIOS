//
//  DateItemView.h
//  zhibo
//
//  Created by qp on 2020/8/5.
//  Copyright © 2020 qp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateItemView : UIView
@property (nonatomic, strong) QMUIButton *dateButton;
@property (nonatomic, strong) QMUIButton *selectButton;

@property (nonatomic, strong) NSString *dateTitle;
@end

NS_ASSUME_NONNULL_END
