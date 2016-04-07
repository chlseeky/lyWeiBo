//
//  IWBasicSettingCell.m
//  ItcastWeibo
//
//  Created by yz on 14/11/17.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWBasicSettingCell.h"
#import "IWSettingItem.h"
#import "IWArrowItem.h"
#import "IWSwitchItem.h"
#import "IWCheakItem.h"
#import "IWBadgeItem.h"
#import "IWBadgeView.h"
#import "IWLabelItem.h"
#import "IWVipItem.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWOtherItem.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Resizable.h"

#define KLabelFone [UIFont systemFontOfSize:14]

@interface IWBasicSettingCell ()

@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UIView *vipView;
@property (nonatomic, strong) UIView *otherView;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UIImageView *cheakView;
@property (nonatomic, strong) IWBadgeView *badgeView;
@property (nonatomic, weak) UILabel *labelView;

@end
@implementation IWBasicSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UILabel *)labelView
{
    if (_labelView == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        _labelView = label;
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.textColor = [UIColor redColor];
        [self addSubview:_labelView];
    }
    return _labelView;
}
- (IWBadgeView *)badgeView
{
    if (_badgeView == nil) {
        _badgeView = [[IWBadgeView alloc] init];
    }
    return _badgeView;
}
- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _arrowView;
}

- (UIImage *)reSizeImage:(UIImage *)image
{
    [image stretchableImageWithLeftCapWidth:image.size.width / 4 topCapHeight:image.size.height / 4];
    return image;
}

- (UIView *)vipView
{
    if (_vipView == nil) {
        self.accessoryView = self.arrowView;
        IWUser *user = [IWUserTool user];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 90)];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage circleImageWithImage:user.profile_user_img borderColor:[UIColor orangeColor] borderWidth:1]];
        imageView.frame = CGRectMake(15, 15, 60, 60);
        
        NSString *fg = user.name;
        CGSize size = [fg sizeWithFont:[UIFont systemFontOfSize:16]];
        NSString *desc = [NSString stringWithFormat:@"%@%@",@"简介：",user.desc];
        CGSize size6 = [desc sizeWithFont:[UIFont systemFontOfSize:12]];
        
        UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right +10, (90-size.height-size6.height -5)/2, size.width, size.height)];
        nameLable.font = [UIFont systemFontOfSize:16];
        nameLable.text = user.name;
        
        UILabel *descripLab = [[UILabel alloc]initWithFrame:CGRectMake(nameLable.left, nameLable.bottom+5, size6.width, size6.height)];
        descripLab.font = [UIFont systemFontOfSize:12];
        descripLab.textColor = [UIColor lightGrayColor];
        descripLab.text = desc;
        
        
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_icon_membership"]];
        img.frame = CGRectMake(kMainScreenWidth-90, (90-26)/2, 26, 26);
        
        fg = @"会员";
        CGSize size1 = [fg sizeWithFont:KLabelFone];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(img.left + img.width+4, (90-size1.height)/2, size1.width, size1.height)];
        label.font = KLabelFone;
        label.text = fg;
        
        [view addSubview:imageView];
        [view addSubview:nameLable];
        [view addSubview:descripLab];
        [view addSubview:img];
        [view addSubview:label];
        _vipView = view;
    }
    return _vipView;
}

-(UIView *)otherView{
    if (!_otherView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 50)];
        IWUser *user = [IWUserTool user];
        NSString *text = @"微博";
        NSString *weibostr = [NSString stringWithFormat:@"%ld", (long)user.statuses_count];
        CGSize size = [text sizeWithFont:KLabelFone];
        CGSize size1 = [weibostr sizeWithFont:KLabelFone];
        UILabel *weiboshu = [[UILabel alloc]initWithFrame:CGRectMake((kMainScreenWidth/3-size1.width)/2, 10,size1.width , size1.height)];
        weiboshu.text = weibostr;
        weiboshu.font = KLabelFone;
        
        UILabel *weibo = [[UILabel alloc]initWithFrame:CGRectMake((kMainScreenWidth/3-size.width)/2, 30,size.width , size.height)];
        weibo.text = text;
        weibo.textColor = [UIColor lightGrayColor];
        weibo.font = KLabelFone;
        
        [view addSubview:weiboshu];
        [view addSubview:weibo];
        
        text = @"关注";
        weibostr = [NSString stringWithFormat:@"%ld", (long)user.friends_count];
        CGSize size2 = [weibostr sizeWithFont:KLabelFone];
        UILabel *guanzhushu = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth/3 + (kMainScreenWidth/3-size2.width)/2, 10,size2.width , size2.height)];
        guanzhushu.text = weibostr;
        
        guanzhushu.font = KLabelFone;
        
        UILabel *guanzhu = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth/3 + (kMainScreenWidth/3-size.width)/2, 30,size.width , size.height)];
        guanzhu.text = text;
        guanzhu.font = KLabelFone;
        guanzhu.textColor = [UIColor lightGrayColor];
        [view addSubview:guanzhushu];
        [view addSubview:guanzhu];
        
        text = @"粉丝";
        weibostr = [NSString stringWithFormat:@"%ld", (long)user.followers_count];
        CGSize size3 = [weibostr sizeWithFont:KLabelFone];
        UILabel *fensishu = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth/3*2 + (kMainScreenWidth/3-size3.width)/2, 10,size3.width , size3.height)];
        fensishu.text = weibostr;
        fensishu.font = KLabelFone;
        
        UILabel *fensi = [[UILabel alloc]initWithFrame:CGRectMake(kMainScreenWidth/3*2 + (kMainScreenWidth/3-size.width)/2, 30,size.width , size.height)];
        fensi.text = text;
        fensi.textColor = [UIColor lightGrayColor];
        fensi.font = KLabelFone;
        
        [view addSubview:fensishu];
        [view addSubview:fensi];
        
        _otherView = view;
    }
    return _otherView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _switchView;
}

- (UIImageView *)cheakView
{
    if (_cheakView == nil) {
        _cheakView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
    }
    return _cheakView;
}



+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    IWBasicSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;

}

- (void)setItem:(IWSettingItem *)item
{
    _item = item;
    
    // 设置数据
    [self setUpData];
    // 设置模型
    [self setUpRightView];
}

- (void)setUpData
{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    self.imageView.image = _item.image;
}

- (void)setUpRightView
{
    if ([_item isKindOfClass:[IWArrowItem class]]) { // 箭头
        self.accessoryView = self.arrowView;
    }else if ([_item isKindOfClass:[IWSwitchItem class]]){ // 开关
        self.accessoryView = self.switchView;
        IWSwitchItem *switchItem = (IWSwitchItem *)_item;
        self.switchView.on = switchItem.on;

    }else if ([_item isKindOfClass:[IWCheakItem class]]){ // 打钩
        IWCheakItem *badgeItem = (IWCheakItem *)_item;
        if (badgeItem.cheak) {
            self.accessoryView = self.cheakView;
        }else{
            self.accessoryView = nil;
        }
    }else if ([_item isKindOfClass:[IWBadgeItem class]]){
        IWBadgeItem *badgeItem = (IWBadgeItem *)_item;
        IWBadgeView *badge = self.badgeView;
        self.accessoryView = badge;
        badge.badgeValue = badgeItem.badgeValue;
    }else if ([_item isKindOfClass:[IWLabelItem class]]){
        IWLabelItem *labelItem = (IWLabelItem *)_item;
        UILabel *label = self.labelView;
        label.text = labelItem.text;
        
    }else if ([_item isKindOfClass:[IWVipItem class]]){
        IWVipItem *labelItem = (IWVipItem *)_item;
        [self addSubview:self.vipView];
    }else if ([_item isKindOfClass:[IWOtherItem class]]){
        [self addSubview:self.otherView];
    }else{ // 没有
        self.accessoryView = nil;
        [_labelView removeFromSuperview];
        _labelView = nil;
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(int)count
{
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selBgView = (UIImageView *)self.selectedBackgroundView;
    if (count == 1) { // 只有一行
        bgView.image = [UIImage resizableWithImageName:@"common_card_background"];
        selBgView.image = [UIImage resizableWithImageName:@"common_card_background_highlighted"];
        
    }else if(indexPath.row == 0){ // 顶部cell
        bgView.image = [UIImage resizableWithImageName:@"common_card_top_background"];
        selBgView.image = [UIImage resizableWithImageName:@"common_card_top_background_highlighted"];
        
    }else if (indexPath.row == count - 1){ // 底部
        bgView.image = [UIImage resizableWithImageName:@"common_card_bottom_background"];
        selBgView.image = [UIImage resizableWithImageName:@"common_card_bottom_background_highlighted"];
        
    }else{ // 中间
        bgView.image = [UIImage resizableWithImageName:@"common_card_middle_background"];
        selBgView.image = [UIImage resizableWithImageName:@"common_card_middle_background_highlighted"];
    }
}

- (void)switchChange:(UISwitch *)switchView
{
    IWSwitchItem *switchItem = (IWSwitchItem *)_item;
    switchItem.on = switchView.on;  
}


@end
