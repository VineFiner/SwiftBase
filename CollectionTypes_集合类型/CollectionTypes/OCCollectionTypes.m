//
//  OCCollectionTypes.m
//  CollectionTypes
//
//  Created by mac on 2018/4/12.
//  Copyright © 2018年 Vine. All rights reserved.
//

#import "OCCollectionTypes.h"

@implementation OCCollectionTypes
+ (void)test{
    // 数组
    [self Array];
    [self NSDictionary];
}
#pragma mark - Array
+ (void)Array {
    NSArray *array = @[@3, @"3", @YES];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"-------->%@",[obj class]);
    }];
}
#pragma mark - NSDictionary

+ (void)NSDictionary {
    NSDictionary *dic = [[NSDictionary alloc]init];
    NSArray *arr = (NSArray *)dic.allKeys;
    NSLog(@"--->%@",arr);
}
@end
