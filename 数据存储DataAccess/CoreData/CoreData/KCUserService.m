//
//  KCUserService.m
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "KCUserService.h"
#import "User.h"
#import "KCDbManager.h"
#import <CoreData/CoreData.h>

@implementation KCUserService
singleton_implementation(KCUserService)

-(NSManagedObjectContext *)context{
    return [KCDbManager sharedKCDbManager].context;
}

-(void)addUser:(User *)user{
    [self addUserWithName:user.name screenName:user.screenName profileImageUrl:user.profileImageUrl mbtype:user.mbtype city:user.city];
}

-(void)addUserWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city{
    //添加一个对象
    User *us= [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.context];
    us.name=name;
    us.screenName=screenName;
    us.profileImageUrl=profileImageUrl;
    us.mbtype=mbtype;
    us.city=city;
    NSError *error;
    //保存上下文
    if (![self.context save:&error]) {
        NSLog(@"添加过程中发生错误,错误信息：%@！",error.localizedDescription);
    }
}

-(User *)getUserByName:(NSString *)name{
    //实例化查询
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"User"];
    //使用谓词查询是基于Keypath查询的，如果键是一个变量，格式化字符串时需要使用%K而不是%@
    request.predicate=[NSPredicate predicateWithFormat:@"%K=%@",@"name",name];
//    request.predicate=[NSPredicate predicateWithFormat:@"name=%@",name];
    NSError *error;
    User *user;
    //进行查询
    NSArray *results=[self.context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"查询过程中发生错误，错误信息：%@！",error.localizedDescription);
    }else{
        user=[results firstObject];
    }
    
    return user;
}

-(void)removeUser:(User *)user{
    [self.context deleteObject:user];
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"删除过程中发生错误，错误信息：%@!",error.localizedDescription);
    }
}

-(void)removeUserByName:(NSString *)name{
    User *user=[self getUserByName:name];
    [self removeUser:user];
}

-(void)modifyUser:(User *)user{
    [self modifyUserWithName:user.name screenName:user.screenName profileImageUrl:user.profileImageUrl mbtype:user.mbtype city:user.city];
}
-(void)modifyUserWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city{
    User *us=[self getUserByName:name];
    us.screenName=screenName;
    us.profileImageUrl=profileImageUrl;
    us.mbtype=mbtype;
    us.city=city;
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"修改过程中发生错误,错误信息：%@",error.localizedDescription);
    }

}


-(NSArray *)getUsersByStatusText:(NSString *)text screenName:(NSString *)screenName{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Status"];
    request.predicate=[NSPredicate predicateWithFormat:@"text LIKE '*Watch*'",text];
    NSArray *statuses=[self.context executeFetchRequest:request error:nil];
    
    NSPredicate *userPredicate= [NSPredicate predicateWithFormat:@"user.screenName=%@",screenName];
    NSArray *users= [statuses filteredArrayUsingPredicate:userPredicate];
    return users;
}
@end
