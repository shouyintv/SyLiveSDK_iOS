//
//  SYLivePlatform.h
//  SYLivePlatform
//
//  Created by ganyanchao on 2017/5/18.
//  Copyright © 2017年 QuanMin.ShouYin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "SyLiveSDKInterface.h"
#import "SyLiveConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface SyLiveSDK : NSObject <SyLiveSDKConformInterface>

/**
 单例对象
 @return 单例对象
 */
+ (instancetype)shareSDK;

- (void)setDelegate:(id<SyLiveSDKInterface>)delegate;

- (void)registerApp:(NSString *)appId;

/**
 登陆接口
 @param sid 三方使用全民sid登陆。
 @param cid 三方使用全民cid登陆。
 */
- (void)login:(NSString *)sid cid:(NSString *)cid;


//跳转具体功能模块。要在登陆成功之后调用有效
/**
 跳转大厅
 */
- (void)jumpToLiveHallFromController:(UIViewController *)viewController;

/**
 跳转 关注列表
 */
- (void)jumpToListFollowFromController:(UIViewController *)viewController;

/**
 跳转 热门列表
 */
- (void)jumpToListHotFromController:(UIViewController *)viewController;

/**
 跳转 最新列表
 */
- (void)jumpToListLatestFromController:(UIViewController *)viewController;

/**
 去 观看直播间
 @param roomId 手印直播房间id，通过列表中获取
 */
- (void)jumpToLiveWatch:(NSInteger)roomId fromController:(UIViewController *)viewController;

/**
 去 开播
 */
- (void)jumpToPushStreamFromController:(UIViewController *)viewController;

/*
 清理缓存
 */
+ (void)clearCache;

/**
 获取sdk版本号
 @return 版本号
 */
+ (NSString *)sdkVersion;

@end


NS_ASSUME_NONNULL_END

