//
//  TeamLowerItemView.m
//  zhibo
//
//  Created by qp on 2020/7/31.
//  Copyright © 2020 qp. All rights reserved.
//

#import "TeamLowerItemView.h"
#import "EditLowerTeamFeeView.h"
@implementation TeamTextItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height/2)];
        self.aLabel.font = [UIFont PingFangMedium:14];
        self.aLabel.textAlignment = NSTextAlignmentCenter;
        self.aLabel.textColor = [UIColor hexColor:@"#474747"];
        [self addSubview:self.aLabel];
        
        self.bLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height/2, self.width, self.height/2)];
        self.bLabel.font = [UIFont PingFangMedium:14];
        self.bLabel.textAlignment = NSTextAlignmentCenter;
        self.bLabel.textColor = [UIColor hexColor:@"#A8A8A8"];
        [self addSubview:self.bLabel];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LINGDIANWU, self.height/2)];
        self.lineView.backgroundColor = [UIColor hexColor:@"#A8A8A8"];
        [self addSubview:self.lineView];
        self.lineView.centerY = self.height/2;
    }
    return self;
}
@end

@interface TeamLowerItemView ()<INetData, EditLowerTeamFeeViewDelegate>
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *idLabel;

@property (nonatomic, strong) TeamTextItem *itemA; //团队
@property (nonatomic, strong) TeamTextItem *itemB; //投注金额
@property (nonatomic, strong) TeamTextItem *itemC; //返点金额
@property (nonatomic, strong) TeamTextItem *itemD; //返点金额
@property (nonatomic, strong) QMUIButton *btn;
@property (nonatomic, strong) QMUIButton *editbtn;

@property (nonatomic, assign) int fee;
@property (nonatomic, assign) NSDictionary *item;
@end

@implementation TeamLowerItemView

- (void)setupAdjustContents {
    self.backgroundColor = [UIColor whiteColor];
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.clipsToBounds = true;
    self.avatarImageView.layer.cornerRadius = 20;
    self.avatarImageView.backgroundColor = [UIColor hexColor:@"f6f6f6"];
    [self addSubview:self.avatarImageView];
    
    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nickNameLabel.font = [UIFont PingFangMedium:14];
    self.nickNameLabel.textColor = [UIColor hexColor:@"868687"];
    [self addSubview:self.nickNameLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.contentLabel.font = [UIFont PingFangSC:14];
    self.contentLabel.textColor = [UIColor hexColor:@"222222"];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    
    self.idLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.idLabel.font = [UIFont PingFangSC:11];
    self.idLabel.textColor = [UIColor hexColor:@"868687"];
    [self addSubview:self.idLabel];
    
    
    CGFloat w = floor(self.width/4);
    self.itemA = [[TeamTextItem alloc] initWithFrame:CGRectMake(0, self.height-55, w, 50)];
    self.itemA.bLabel.text = @"团队人数";
    [self addSubview:self.itemA];

    self.itemB = [[TeamTextItem alloc] initWithFrame:CGRectMake(w, self.height-55, w, 50)];
    self.itemB.bLabel.text = @"投注金额";
    [self addSubview:self.itemB];

    self.itemC = [[TeamTextItem alloc] initWithFrame:CGRectMake(w*2, self.height-55, w, 50)];
    self.itemC.bLabel.text = @"返点金额";
    [self addSubview:self.itemC];
    
    self.itemD = [[TeamTextItem alloc] initWithFrame:CGRectMake(w*3, self.height-55, w, 50)];
    self.itemD.bLabel.text = @"返点比例";
    [self addSubview:self.itemD];
    
    self.btn = [[QMUIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    [self.btn setTitle:@"查看" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor hexColor:@"#C6CCDD"] forState:UIControlStateNormal];
    self.btn.titleLabel.font = [UIFont PingFangSC:12];
    [self addSubview:self.btn];
//    [self.btn addTarget:self action:@selector(onChakan) forControlEvents:UIControlEventTouchUpInside];
    [self.btn setUserInteractionEnabled:false];
    
    self.editbtn = [[QMUIButton alloc] initWithFrame:CGRectMake(self.width-65, self.height-45, 60, 35)];
    [self.editbtn setTitle:@"修改" forState:UIControlStateNormal];
    self.editbtn.layer.cornerRadius = self.editbtn.height/2;
    [self.editbtn setBackgroundColor:[UIColor hexColor:@"#FF2828"]];
    [self.editbtn setTitleColor:[UIColor hexColor:@"#ffffff"] forState:UIControlStateNormal];
    self.editbtn.titleLabel.font = [UIFont PingFangSC:15];
    [self addSubview:self.editbtn];
    [self.editbtn addTarget:self action:@selector(onChakan) forControlEvents:UIControlEventTouchUpInside];
//    [self.editbtn setUserInteractionEnabled:false];
}

- (void)layoutAdjustContents {
    self.avatarImageView.left = 15;
    self.avatarImageView.top = 11;
    
    self.nickNameLabel.left = self.avatarImageView.right+10;
    self.nickNameLabel.top = self.avatarImageView.centerY-self.nickNameLabel.height;
    
    self.idLabel.left = self.nickNameLabel.left;
    self.idLabel.top = self.avatarImageView.centerY;
    self.itemA.top = self.height-55;
    self.itemB.top = self.height-55;
    self.itemC.top = self.height-55;
    self.itemD.top = self.height-55;
    
    self.btn.left = self.width-15-40;
    self.btn.centerY = self.avatarImageView.centerY;
    
    self.editbtn.centerY = self.avatarImageView.centerY;
    
}

- (void)reload:(NSDictionary *)item extra:(NSDictionary *)extra indexPath:(NSIndexPath *)indexPath {
    self.item = item;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:item[@"avatar"]] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    self.nickNameLabel.text = item[@"nickname"];
    [self.nickNameLabel sizeToFit];
    
    self.idLabel.text = [NSString stringWithFormat:@"ID:%@", item[@"user_id"]];
    [self.idLabel sizeToFit];
    
    
    [self.itemA setHidden:true];
    [self.itemB setHidden:true];
    [self.itemC setHidden:true];
    [self.itemD setHidden:true];
    [self.btn setHidden:false];
    [self.editbtn setHidden:true];
    self.fee = 0;
    if (extra[@"info"]) {
        [self.editbtn setHidden:false];
        [self.btn setHidden:true];
        [self.itemA setHidden:false];
        [self.itemB setHidden:false];
        [self.itemC setHidden:false];
        [self.itemD setHidden:false];
        NSDictionary *info = extra[@"info"];
        self.fee = [info[@"fee"] intValue];
        self.itemA.aLabel.text = [info stringValueForKey:@"teamcount"];
        self.itemB.aLabel.text = [info stringValueForKey:@"betsmoney"];
        self.itemC.aLabel.text = [info stringValueForKey:@"feemoney"];
        self.itemD.aLabel.text = [NSString stringWithFormat:@"%@%%", [info stringValueForKey:@"fee"]];
    }
//    self.itemA.aLabel.text = @"2000";
//    self.itemB.aLabel.text = @"555";
//    self.itemC.aLabel.text = @"1111";
//    NSArray *titles = @[@"团队人数", @""]
//    for (int i=0; i<3; i++) {
//        <#statements#>
//    }
}

- (void)onChakan {
    [self fetchPostUri:@"/UserQrCode" params:nil];
}

- (void)onNetRequestSuccess:(ABNetRequest *)req obj:(NSDictionary *)obj isCache:(BOOL)isCache {
    EditLowerTeamFeeView *feeView = [[EditLowerTeamFeeView alloc] initWithFrame:CGRectMake(30, 100, SCREEN_WIDTH-60, 200)];
    feeView.maxValue = MAX([obj[@"MaxFee"] intValue], 0);
    feeView.progressView.minValue = self.fee;
    feeView.uid = [_item[@"user_id"] intValue];
    feeView.delegate = self;
    [[ABUIPopUp shared] show:feeView from:ABPopUpDirectionCenter];
}


- (void)onNetRequestFailure:(ABNetRequest *)req err:(ABNetError *)err {
    [ABUITips showError:err.message];
}

- (void)onUpdateSuccessed {
    [self.cell sendActionWithData:_item[@"user_id"] forKey:@"refresh"];
}

@end
