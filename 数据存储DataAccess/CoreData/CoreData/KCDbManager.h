//
//  DbManager.h
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KCSingleton.h"

@interface KCDbManager : NSObject

singleton_interface(KCDbManager);

#pragma mark - 属性
#pragma mark 数据库引用，使用它进行数据库操作
@property (nonatomic) NSManagedObjectContext *context;


#pragma mark - 共有方法
/**
 *  打开数据库
 *
 *  @param dbname 数据库名称
 */
-(NSManagedObjectContext *)createDbContext;

///**
// *  执行无返回值的sql
// *
// *  @param sql sql语句
// */
//-(void)executeNonQuery:(NSString *)sql;
//
///**
// *  执行有返回值的sql
// *
// *  @param sql sql语句
// *
// *  @return 查询结果
// */
//-(NSArray *)executeQuery:(NSString *)sql;
@end
