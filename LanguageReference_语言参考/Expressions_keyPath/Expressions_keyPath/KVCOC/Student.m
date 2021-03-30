//
//  Student.m
//  net_day2_04_kvc
//
//  Created by 张广洋 on 15/12/29.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import "Student.h"

@implementation Student

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"UndefinedKey___%@ %@",value,key);
}

@end
