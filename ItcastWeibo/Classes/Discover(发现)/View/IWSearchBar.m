//
//  IWSearchBar.m
//  ItcastWeibo
//
//  Created by yz on 14/11/6.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWSearchBar.h"

@interface IWSearchBar()

@property (nonatomic,strong)UIButton *jTBtn;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *searBtn;

@end

@implementation IWSearchBar

-(UIButton *)jTBtn{
    if (!_jTBtn) {
        _jTBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _jTBtn.center = self.field.leftView.center;
        [_jTBtn setImage:[UIImage imageNamed:@"searchbar_textfield_down_icon"] forState:UIControlStateNormal];
    }
    return _jTBtn;
}

-(UIButton *)searBtn{
    if (!_searBtn) {
        _searBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _searBtn.center = self.field.leftView.center;
        //leftV.contentMode = UIViewContentModeCenter;
        [_searBtn setImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"] forState:UIControlStateNormal];
    }
    return _searBtn;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width-40, 0, 40, 28)];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        _cancelBtn.contentMode = UIViewContentModeCenter;
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UITextField *)field{
    if (!_field) {
        UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.width-kMainScreenWidth/20, 28)];
        text.placeholder =  @"大家都在搜：减肥暴力锁屏";
        text.font = [UIFont systemFontOfSize:13];
        text.background = [UIImage resizableWithImageName:@"searchbar_square_background"];
        text.layer.cornerRadius = 5.0;
        
        text.leftView = self.searBtn;
        text.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        text.leftViewMode = UITextFieldViewModeAlways;
        _field = text;
    }
    return _field;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.field];
//        self.placeholder =  @"大家都在搜：减肥暴力锁屏";
//        self.font = [UIFont systemFontOfSize:13];
//        self.background = [UIImage resizableWithImageName:@"searchbar_textfield_background"];
//        
//        UIImageView *leftV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 32)];
//        leftV.contentMode = UIViewContentModeCenter;
//        leftV.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
//        self.leftView = leftV;
//        
//        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

-(void)showOthers:(BOOL)show{
    if (show) {
        self.field.width -=47;
        [self.searBtn removeFromSuperview];
        self.field.leftView = self.jTBtn;
        [self addSubview:self.cancelBtn];
    }else{
        self.field.width +=47;
        [self.jTBtn removeFromSuperview];
        self.field.leftView = self.searBtn;
        [self.cancelBtn removeFromSuperview];
    }
}

-(void)btnClick{
    if ([self.aDelegate respondsToSelector:@selector(cancelBtnClick)]) {
        [self.aDelegate cancelBtnClick];
    }
}

@end
