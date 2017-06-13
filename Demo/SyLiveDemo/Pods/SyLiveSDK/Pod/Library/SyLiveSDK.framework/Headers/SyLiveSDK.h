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


/**
 启动时候调用
 @param appId 手印平台注册获取
 */
- (void)registerApp:(NSString *)appId;

/**
建议第三方，在用户在自己平台登陆后，获取唯一uuid后，调用.
 登陆结果在 SyLiveSDKInterface 协议中获取
 
 @param uuid 第三方uuid
 @param utoken 第三方根据uid生成的utoken签名验证
 */
- (void)login:(NSString *)uuid token:(NSString *)utoken;

//- (void)loginOut; /**< 登出调用*/

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
- (void)jumpToTakeFromController:(UIViewController *)viewController;

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

