//
//  Dimension.m
//  Subscripts
//
//  Created by mac on 2018/4/17.
//  Copyright © 2018年 Vine. All rights reserved.
//

#import "Dimension.h"

@implementation Dimension
+ (void)test {
    // 这里创建二维数组
    NSArray *array1 = [NSArray arrayWithObjects:@"iOS",@"android",@"C",@"C++",@"OC",@"JAVA", nil];
    NSArray *array2 = [NSArray arrayWithObjects:array1, @"php",@"c#",@"FMDB",@"sqlite",@"odbc",@"photoshop", nil];
    NSArray *array3 = [NSArray arrayWithObjects:array2, @"javascript",@"xml",@"html",@"cocos2D",@"u3d",@"sjjg", nil];
    NSArray *array = [NSArray arrayWithObjects:array1, array2, array3, nil];
    NSLog(@"--->%@",array);
    NSLog(@"--->%@",array[2][0][0][0]);
}
@end
