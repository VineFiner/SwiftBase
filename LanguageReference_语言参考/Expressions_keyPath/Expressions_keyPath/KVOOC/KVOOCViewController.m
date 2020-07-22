//
//  KVOOCViewController.m
//  Expressions_keyPath
//
//  Created by vine on 2019/12/2.
//  Copyright © 2019 vine. All rights reserved.
//

#import "KVOOCViewController.h"

@interface Vegetable : NSObject

//名字
@property (nonatomic,copy) NSString * name;
//价格
@property (nonatomic) float price;

@end
@implementation Vegetable

@end

#pragma mark -

@interface KVOOCViewController ()
{
    //这是个黄瓜
    Vegetable * _cucumber;
}
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation KVOOCViewController

-(void)dealloc{
    //kvo移除观察
    [_cucumber removeObserver:self forKeyPath:@"price"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _cucumber=[[Vegetable alloc]init];
    _cucumber.name=@"黄瓜";
    _cucumber.price=2.5;
    self.priceLabel.text=[NSString stringWithFormat:@"%f",_cucumber.price];
    //使用KVO，添加一个观察对象，观察price属性
    [_cucumber addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}
//响应属性值变化后的方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"%@  %@  %@",keyPath,change,[object class]);
    if ([keyPath isEqualToString:@"price"]) {
        NSNumber * newPrice=change[@"new"];
        self.priceLabel.text=[NSString stringWithFormat:@"%@",newPrice];
    }
}
- (IBAction)changePrice:(UIButton *)sender {
    //    _cucumber.price-=0.5;
    [_cucumber setValue:@(0.8) forKey:@"price"];
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
