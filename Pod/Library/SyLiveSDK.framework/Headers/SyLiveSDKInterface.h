//
//  SYLiveDelegate.h
//  SYLivePlatform
//
//  Created by ganyanchao on 2017/5/18.
//  Copyright © 2017年 QuanMin.ShouYin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyLiveConfig.h"

@protocol SyLiveSDKInterface <NSObject>

@required

/**
 接入方 要自己处理分享出去的对象
 
 @param shareConfig 分享对象
 */
- (void)onShareMessage:(SyLiveShareConfig *)shareConfig;


@optional
- (void)onLoginResult:(SyLiveLoginCode)code; /**< 查询登陆结果*/


@end


@protocol SyLiveSDKConformInterface <NSObject>


/**
 分享结果回掉
 @param success YES成功 NO失败
 */
- (void)syLiveSharePlatform:(SyLiveSharePlatform)platform result:(BOOL)success;

@end
