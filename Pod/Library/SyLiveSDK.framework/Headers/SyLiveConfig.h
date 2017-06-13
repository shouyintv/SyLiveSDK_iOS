//
//  SyLiveConfig.h
//  SyLiveSDK
//
//  Created by ganyanchao on 2017/5/25.
//  Copyright © 2017年 QuanMin.ShouYin. All rights reserved.
//

#ifndef SyLiveConfig_h
#define SyLiveConfig_h


#endif /* SyLiveConfig_h */


typedef NS_ENUM(NSInteger, SyLiveLoginCode) {
    LoginCodePackageIllegal = -1000,        /**< 包名不合法*/
    LoginCodeSuccess        = 200,          /**< 登陆成功*/
};


typedef NS_ENUM(NSInteger, SyLiveSharePlatform) {
    SyLiveSharePlatformWeixin = 0,          // 微信
    SyLiveSharePlatformWeixinCircle = 1,    // 微信朋友圈
    SyLiveSharePlatformWeibo = 2,           // 新浪微博
    SyLiveSharePlatformQQ = 3,              // QQ
    SyLiveSharePlatformQQzone = 4,          // QQ空间
};


@interface SyLiveShareConfig : NSObject

@property (nonatomic, copy) NSString * _Nullable title;     /**< 标题*/
@property (nonatomic, copy) NSString * _Nullable desc;      /**< 详情*/
@property (nonatomic, copy) NSString * _Nullable shareUrl;  /**< 链接*/
@property (nonatomic, strong) UIImage * _Nullable image;    /**< 图片*/
@property (nonatomic, copy) NSString * _Nullable imageUrl;  /**< 图片链接*/
@property (nonatomic, assign) SyLiveSharePlatform  sharePlatform; /**< 分享平台*/

@end
