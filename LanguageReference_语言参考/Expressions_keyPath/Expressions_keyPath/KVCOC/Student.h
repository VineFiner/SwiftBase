//
//  Student.h
//  net_day2_04_kvc
//
//  Created by 张广洋 on 15/12/29.
//  Copyright © 2015年 张广洋. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Teacher.h"

@interface Student : NSObject

//姓名
@property (nonatomic,copy) NSString * name;
//成绩
@property (nonatomic) float score;
//老师
@property (nonatomic,strong) Teacher * teacher;

@end










