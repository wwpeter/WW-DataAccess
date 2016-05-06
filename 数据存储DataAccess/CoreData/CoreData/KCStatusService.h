//
//  KCStatusService.h
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCSingleton.h"
#import <CoreData/CoreData.h>
@class Status;
@class User;

@interface KCStatusService : NSObject
singleton_interface(KCStatusService)

@property (nonatomic,strong) NSManagedObjectContext *context;

/**
 *  添加微博信息
 *
 *  @param status 微博对象
 */
-(void)addStatus:(Status *)status;

/**
 *  添加微博信息
 *
 *  @param date   创建日期
 *  @param source 设备来源
 *  @param text   微博内容
 *  @param user   发送用户
 */
-(void)addStatusWithCreatedAt:(NSDate *)createdAt source:(NSString *)source text:(NSString *)text user:(User *)user;

/**
 *  删除微博
 *
 *  @param status 微博对象
 */
-(void)removeStatus:(Status *)status;


/**
 *  取得所有微博对象
 *
 *  @return 所有微博对象
 */
-(NSArray *)getAllStatus;

-(NSArray *)getStatusesByUserName:(NSString *)name;

@end
