//
//  IWSearchBar.h
//  ItcastWeibo
//
//  Created by yz on 14/11/6.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IWSearchBarDelegate <NSObject>

-(void)cancelBtnClick;

@end

@interface IWSearchBar : UIView

@property (nonatomic,strong)UITextField *field;
@property (nonatomic,weak)id<IWSearchBarDelegate> aDelegate;

-(void)showOthers:(BOOL)show;
@end
