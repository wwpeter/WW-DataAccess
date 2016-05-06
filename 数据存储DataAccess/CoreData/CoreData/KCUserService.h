//
//  KCUserService.h
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "KCSingleton.h"
#import <CoreData/CoreData.h>

@interface KCUserService : NSObject
singleton_interface(KCUserService)

@property (nonatomic,strong) NSManagedObjectContext *context;

/**
 *  添加用户信息
 *
 *  @param user 用户对象
 */
-(void)addUser:(User *)user;

/**
 *  添加用户
 *
 *  @param name            用户名
 *  @param screenName      用户昵称
 *  @param profileImageUrl 用户头像
 *  @param mbtype          会员类型
 *  @param city            用户所在城市
 */
-(void)addUserWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city;

/**
 *  删除用户
 *
 *  @param user 用户对象
 */
-(void)removeUser:(User *)user;

/**
 *  根据用户名删除用户
 *
 *  @param name 用户名
 */
-(void)removeUserByName:(NSString *)name;

/**
 *  修改用户内容
 *
 *  @param user 用户对象
 */
-(void)modifyUser:(User *)user;

/**
 *  修改用户信息
 *
 *  @param name            用户名
 *  @param screenName      用户昵称
 *  @param profileImageUrl 用户头像
 *  @param mbtype          会员类型
 *  @param city            用户所在城市
 */
-(void)modifyUserWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city;


/**
 *  根据用户名取得用户
 *
 *  @param name 用户名
 *
 *  @return 用户对象
 */
-(User *)getUserByName:(NSString *)name;

-(NSArray *)getUsersByStatusText:(NSString *)text screenName:(NSString *)screenName;
@end
