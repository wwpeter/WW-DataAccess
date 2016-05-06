//
//  DbManager.m
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "KCDbManager.h"
#import <sqlite3.h>
#import "KCSingleton.h"
#import "KCAppConfig.h"
#import "FMDB.h"

#ifndef kDatabaseName

#define kDatabaseName @"myDatabase.db"

#endif

@interface KCDbManager()
@end

@implementation KCDbManager

singleton_implementation(KCDbManager)

#pragma mark 重写初始化方法
-(instancetype)init{
    KCDbManager *manager;
    if((manager=[super init]))
    {
        [manager openDb:kDatabaseName];
    }
    return manager;
}

-(void)openDb:(NSString *)dbname{
    //取得数据库保存路径，通常保存沙盒Documents目录
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"%@",directory);
    NSString *filePath=[directory stringByAppendingPathComponent:dbname];
    //创建FMDatabase对象
    self.database=[FMDatabase databaseWithPath:filePath];
    //打开数据上
    if ([self.database open]) {
        NSLog(@"数据库打开成功!");
    }else{
        NSLog(@"数据库打开失败!");
    }
}

-(void)executeNonQuery:(NSString *)sql{
    char *error;
    //执行更新sql语句，用于插入、修改、删除
    if ([self.database executeUpdate:sql]) {
        NSLog(@"执行SQL语句过程中发生错误！错误信息：%s",error);
    }
}

-(FMResultSet *)executeQuery:(NSString *)sql{
    NSMutableArray *array=[NSMutableArray array];
    //执行查询sql语句
    FMResultSet *result= [self.database executeQuery:sql];
    while (result.next) {
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        for (int i=0; i<result.columnCount; ++i) {
            dic[[result columnNameForIndex:i]]=[result stringForColumnIndex:i];
        }
        [array addObject:dic];
    }
    return array;
}
@end
