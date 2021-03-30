//
//  KVCOCViewController.m
//  Expressions_keyPath
//
//  Created by vine on 2019/12/2.
//  Copyright © 2019 vine. All rights reserved.
//

#import "KVCOCViewController.h"
#import "Student.h"

@interface KVCOCViewController ()
{
    //
    Student * _someOne;
}
@end

@implementation KVCOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _someOne=[[Student alloc]init];
    _someOne.name=@"叶良辰";
    _someOne.score=60;
    _someOne.teacher=[[Teacher alloc]init];
    _someOne.teacher.age=18;
}
- (void)changeProperty {
    float newScore=_someOne.score-1;
    //用kvc修改属性的值
    [_someOne setValue:@"小红" forKey:@"namess"];
    /*
     @{@"name":@"xiaogang",@"age":@"2"};
     @[@"A",@"B"];
     @();
     */
    [_someOne setValue:@(newScore) forKey:@"score"];
    NSLog(@"%@",_someOne.name);
    NSLog(@"%f",_someOne.score);
    //修改属性的属性的值
    [_someOne setValue:@(17) forKeyPath:@"teacher.age"];
    NSLog(@"%d",_someOne.teacher.age);
    
    
    //kvc获取属性的值
    NSLog(@"-->%@",[_someOne valueForKey:@"name"]);
    NSLog(@"-->%@",[_someOne valueForKeyPath:@"teacher.age"]);
    
    NSArray *testArray = [NSArray arrayWithObjects:@"2.0", @"2.3", @"3.0", @"4.0", nil];
    NSNumber *sum = [testArray valueForKeyPath:@"@sum.floatValue"];
    NSLog(@"%@",sum);
    NSNumber *avg = [testArray valueForKeyPath:@"@avg.floatValue"];
    NSLog(@"%@",avg);
    NSNumber *max = [testArray valueForKeyPath:@"@max.floatValue"];
    NSLog(@"%@",max);
    NSNumber *min = [testArray valueForKeyPath:@"@min.floatValue"];
    NSLog(@"%@",min);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
