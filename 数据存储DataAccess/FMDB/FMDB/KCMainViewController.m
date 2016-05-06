//
//  KCMainViewController.m
//  FMDB
//
//  Created by Kenshin Cui on 14-03-27.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import "KCMainViewController.h"
#import "KCDatabaseCreator.h"

@interface KCMainViewController ()

@end

@implementation KCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [KCDatabaseCreator initDatabase];
}



@end
