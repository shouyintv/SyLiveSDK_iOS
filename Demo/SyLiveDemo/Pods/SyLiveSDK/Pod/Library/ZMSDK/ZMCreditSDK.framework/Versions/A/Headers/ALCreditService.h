//
//  ALCreditService.h
//  SesameCreditMiniSDK
//
//  Created by leodi on 15/8/3.
//  Copyright (c) 2015年 SesameCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ALCreditService : NSObject


+(ALCreditService *)sharedService;

/***
 * 注册应用
 */
-(void)resgisterApp;

/***
 * 用户授权接口
 * @param appId         芝麻分配的应用ID
 * @param sign          商户私钥对params进行加签
 * @param params        授权的请求参数，商户需用芝麻信用的公钥对这一串数据进行RSA加密。
 *                      数据格式如下(具体参数意义请看开发文档)
 * @param targetVC      目标controller,商户Controller必须是基于Navigation Controller
 * @param extParams     新增扩展参数
 * @param block         返回结果在resultDic的字典中
 */
- (void)queryUserAuthReq:(NSString *)appId
                    sign:(NSString *)sign
                  params:(NSString *)params
                  target:(id)targetVC
               extParams:(NSMutableDictionary *)extParams
                   block:(void (^)(NSMutableDictionary* resultDic))block;

/***
 * 用户认证接口
 * @param appId         芝麻分配的应用ID
 * @param sign          商户私钥对params进行加签
 * @param params        授权的请求参数，商户需用芝麻信用的公钥对这一串数据进行RSA加密。
 *                      数据格式如下(具体参数意义请看开发文档)
 * @param method        认证方法
 * @param targetVC      目标controller,商户Controller必须是基于Navigation Controller
 * @param extParams     新增扩展参数
 * @param block         返回结果在resultDic的字典中
 */
- (void)certifyUserInfoReq:(NSString *)appId
                     sign:(NSString *)sign
                   params:(NSString *)params
                   target:(id)targetVC
                extParams:(NSMutableDictionary *)extParams
                    block:(void(^)(NSMutableDictionary* resultDic))block;

/***
 * 设置当前网关环境变量
 * @param env 网关环境变量 
 *            默认是线上环境
 *            测试环境请传入 "mock"
 **/
- (void)setCurrentEnv:(NSString *)env;

/***
 * 设置导航栏颜色
 * @param color       导航栏颜色
 *        titleColor  字体颜色
 */
- (void)setNaviBarColor:(UIColor *)color titleColor:(UIColor *)titleColor;


- (void)verifyInfoReq:(NSString *)appId
                 sign:(NSString *)sign
               params:(NSString *)params
               method:(NSString *)method
            extParams:(NSMutableDictionary *)extParams
                block:(void (^)(NSString* result))block;

@end
