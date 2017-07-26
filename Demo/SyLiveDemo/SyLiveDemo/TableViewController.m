//
//  ViewController.m
//  SyLiveDemo
//
//  Created by ganyanchao on 2017/6/13.
//  Copyright © 2017年 QuanMin.ShouYin. All rights reserved.
//

#import "TableViewController.h"
#import <SyLiveSDK/SyLiveSDK.h>

@interface TableViewController ()<SyLiveSDKInterface,UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITextField *uidTF;
@property (weak, nonatomic) IBOutlet UITextField *owidTF;

@end

@implementation TableViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.sdk setDelegate:self];
}

#pragma mark - SyLiveSDK

- (IBAction)login:(UIButton *)sender {
    NSString *sid = nil;
    if (_uidTF.text.length > 0) {
        sid = _uidTF.text;
    }
    else {
        sid = @"9f2163e498cc6bcb92a965385282ddb0";
    }
    [self.sdk login:sid cid:@"1"];
}

- (NSArray *)actions
{
    static NSArray * rowActions;
    if (rowActions == nil) {
        rowActions = @[
                       @"jumpToHall",
                       @"jumpToFollow",
                       @"jumpToHot",
                       @"jumpToLatest",
                       @"jumpToWatch",
                       @"jumpToTake",
                       ];
    }
    return rowActions;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *actionDo = [self.actions objectAtIndex:indexPath.row];
    [self performSelector:NSSelectorFromString(actionDo) withObject:nil];
}

- (IBAction)jumpToHall {
    
    [self.sdk  jumpToLiveHallFromController:self];
}

- (void)jumpToFollow
{
    [self.sdk jumpToListFollowFromController:self];
}

- (void)jumpToHot
{
    [self.sdk  jumpToListHotFromController:self];
}

- (void)jumpToLatest
{
    [self.sdk  jumpToListLatestFromController:self];
}

- (void)jumpToWatch
{
    NSInteger roomid = [self.owidTF.text integerValue];
    if (roomid == 0) {
        roomid = 9746373;
    }
    [self.sdk  jumpToLiveWatch:roomid fromController:self];
}

- (void)jumpToTake
{
    [self.sdk jumpToPushStreamFromController:self];
}


#pragma mark  SyLiveSDKInterface
- (void)onLoginResult:(SyLiveLoginCode)code
{
    NSLog(@"response code %zi",code);
}

#pragma mark - Setter Getter
- (SyLiveSDK *)sdk
{
    return [SyLiveSDK shareSDK];
}


#pragma mark -  supportedInterfaceOrientations
// 支持屏幕旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

// 只支持竖向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

//画面一开始加载时就是竖向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}



@end
