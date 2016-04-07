//
//  IWProfileViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/4.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWProfileViewController.h"
#import "IWGroupItem.h"
#import "IWArrowItem.h"
#import "IWProfileCell.h"
#import "IWSettingViewController.h"
#import "IWVipItem.h"
#import "IWUserTool.h"
#import "IWAccountTool.h"
#import "IWUser.h"
#import "IWOtherItem.h"
#import "UIButton+WebCache.h"

@interface IWProfileViewController ()

@end

@implementation IWProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    
    [self setUpGroup00];
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
    // 添加第4组
    [self setUpGroup4];
    // 添加第5组
    [self setUpGroup5];
    
}
- (void)setUpGroup00{
    IWVipItem *vip = [[IWVipItem alloc]init];
    
    IWOtherItem *other = [[IWOtherItem alloc]init];
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[vip,other];
    [self.groups addObject:group];
}

- (void)setUpGroup0
{
    // 新的好友
    IWArrowItem *friend = [IWArrowItem itemWithTitle:@"新的好友" image:[UIImage imageNamed:@"new_friend"]];
    IWArrowItem *level = [IWArrowItem itemWithTitle:@"微博等级" image:[UIImage imageNamed:@"new_friend"]];
    level.subTitle = @"升等级，的奖励";
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[friend,level];
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    // 我的相册
    IWArrowItem *album = [IWArrowItem itemWithTitle:@"我的相册" image:[UIImage imageNamed:@"album"]];
    album.subTitle = @"(12)";
    
    // 我的收藏
    IWArrowItem *collect = [IWArrowItem itemWithTitle:@"我的点评" image:[UIImage imageNamed:@"collect"]];
    collect.subTitle = @"(0)";
    
    // 赞
    IWArrowItem *like = [IWArrowItem itemWithTitle:@"我的赞" image:[UIImage imageNamed:@"like"]];
    like.subTitle = @"(0)";
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[album,collect,like];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 微博支付
    IWArrowItem *pay = [IWArrowItem itemWithTitle:@"微博支付" image:[UIImage imageNamed:@"pay"]];
    pay.subTitle = @"积分好礼换不停";
    // 个性化
    IWArrowItem *vip = [IWArrowItem itemWithTitle:@"微博运动" image:[UIImage imageNamed:@"vip"]];
    vip.subTitle = @"奔跑2016搬到这里啦";
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[pay,vip];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 粉丝头条
    IWArrowItem *card = [IWArrowItem itemWithTitle:@"粉丝头条" image:[UIImage imageNamed:@"card"]];
    card.subTitle = @"推广博文及账号的利器";
    // 粉丝服务
    IWArrowItem *draft = [IWArrowItem itemWithTitle:@"粉丝服务" image:[UIImage imageNamed:@"draft"]];
    draft.subTitle = @"橱窗、私信、营销、数据中心";
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[card,draft];
    [self.groups addObject:group];
}

- (void)setUpGroup4
{
    // 草稿箱
    IWArrowItem *draft = [IWArrowItem itemWithTitle:@"草稿箱" image:[UIImage imageNamed:@"card"]];
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[draft];
    [self.groups addObject:group];
}

- (void)setUpGroup5
{
    // 更多
    IWArrowItem *more = [IWArrowItem itemWithTitle:@"更多" image:[UIImage imageNamed:@"card"]];
    more.subTitle = @"文章、收藏";
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[more];
    [self.groups addObject:group];
}
- (void)setUpNav
{
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem = setting;
}

- (void)setting
{
    IWSettingViewController *settingVc = [[IWSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWProfileCell *cell = [IWProfileCell cellWithTableView:tableView];
    
    // 获取模型
    IWGroupItem *groupItem = self.groups[indexPath.section];
    IWSettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
    [cell setIndexPath:indexPath rowCount:groupItem.items.count];
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    // 获取微博昵称
//    [IWUserTool userInfoDidsuccess:^(IWUser *user) {
//        MLOG(@"用户描述--------------------------------：%@",user.desc);
//        //网络请求图片，然后归档当前用户
//        SDWebImageManager *manager = [SDWebImageManager sharedManager];
//        [manager downloadImageWithURL:user.avatar_large options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            
//        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//            user.profile_user_img = image;
//            [IWUserTool saveUser:user];
//        }];
//        
//    } failure:^(NSError *error) {
//        
//    }];
////        //http://tp2.sinaimg.cn/2624257965/50/5745244229/1
////        //http://tp1.sinaimg.cn/1404376560/180/0/1
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
