//
//  AnchorPresent.h
//  zhibo
//
//  Created by FaiWong on 2020/4/24.
//  Copyright © 2020 qp. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@protocol AnchorPresentDelegate <NSObject>
@optional
- (void)onReceiveAnchorList;
- (void)onReceiveAnchorListFailure;
@end
@interface AnchorPresent : NSObject
@property (nonatomic, weak) id<AnchorPresentDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *anchorList;
@property (nonatomic, assign) BOOL isPullRefresh;
- (void)getAnchorList:(NSDictionary *)props;


@end

NS_ASSUME_NONNULL_END
