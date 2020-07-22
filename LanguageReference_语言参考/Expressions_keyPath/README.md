#  <#Title#>

    1 KVC：Key-Value Coding键值编码，是一个非正式的协议，它提供一种机制来间接访问对象的属性。直接访问对象是通过调用访问器的方法实现，而kvc不需要调用访问器的设置和获取方法，可以直接访问对象的属性。
    1）对属性赋值
　　kvc是通过键值对的方式对属性设置值，提供了下面的方法，相当于访问器中的set方法。value为要设置的值，key是字符串，字符串中内容为为属性的名称


- (void)setValue:(id)value forKey:(NSString *)key; - (void)setValue:(id)value forKeyPath:(NSString *)keyPath;
    2）获取属性的值
　　kvc提供了获取对象属性值的方法，相当于访问器的get方法，取值的时候也是通过键值对方式。


- (id)valueForKey:(NSString *)key; - (id)valueForKeyPath:(NSString *)keyPath;
　　下面通过一个小例子讲解一下通过访问器和kvc对属性取值的代码实现。
　　假设要获取Student类中name的值，直接对name取值的方式为：
    3）key找不到时，处理异常
　　使用kvc时，如果代码中的key值不存在，会抛出异常，可以在类中通过重写它提供下面的这个方法来解决这个问题。


- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
　　当key不存在时，会自动调用上面的这个方法，可以在这个方法中进行处理。
    4）kvc的用法补充
　　kvc非常好用，可以简化我们的代码，除了可以不用通过访问器方法，直接对属性进行访问外，还可以对对象中的属性进行运算。
　　NSArray *testArray = [NSArray arrayWithObjects:@"2.0", @"2.3", @"3.0", @"4.0", nil];
    NSNumber *sum = [testArray valueForKeyPath:@"@sum.floatValue"];
    NSLog(@"%@",sum);
    NSNumber *avg = [testArray valueForKeyPath:@"@avg.floatValue"];
    NSLog(@"%@",avg);
    NSNumber *max = [testArray valueForKeyPath:@"@max.floatValue"];
    NSLog(@"%@",max);
    NSNumber *min = [testArray valueForKeyPath:@"@min.floatValue"];
    NSLog(@"%@",min);



    2，KVO,即：Key-Value Observing，它提供一种机制，当指定的对象的属性被修改后，则对象就会接受到通知。简单的说就是每次指定的被观察的对象的属性被修改后，KVO就会自动通知相应的观察者了。
    使用方法
    1）注册，指定被观察者的属性，
[_oneStudent addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    2）实现回调方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@",change);
    if([keyPath isEqualToString:@"score"])
    {
        self.label.text = [NSString stringWithFormat:@"%@",[_oneStudent valueForKey:@"score"]];
    }
}
    3）移除观察
[_oneStudent removeObserver:self forKeyPath:@"score"];

https://www.jianshu.com/p/f1393d10109d



