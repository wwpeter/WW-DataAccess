
//
//  KCDatabaseCreator.m
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "KCDatabaseCreator.h"
#import "KCDbManager.h"

@implementation KCDatabaseCreator

+(void)initDatabase{
    NSString *key=@"IsCreatedDb";
    NSUserDefaults *defaults=[[NSUserDefaults alloc]init];
    if ([[defaults valueForKey:key] intValue]!=1) {
        [self createUserTable];
        [self createStatusTable];
        [defaults setValue:@1 forKey:key];
    }
}

+(void)createUserTable{
    NSString *sql=@"CREATE TABLE User (Id integer PRIMARY KEY AUTOINCREMENT,name text,screenName text, profileImageUrl text,mbtype text,city text)";
    [[KCDbManager sharedKCDbManager] executeNonQuery:sql];
}

+(void)createStatusTable{
    NSString *sql=@"CREATE TABLE Status (Id integer PRIMARY KEY AUTOINCREMENT,source text,createdAt date,\"text\" text,user integer REFERENCES User (Id))";
    [[KCDbManager sharedKCDbManager] executeNonQuery:sql];
}
@end
