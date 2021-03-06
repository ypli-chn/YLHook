[Aspects](https://github.com/steipete/Aspects) is a delightful, simple library for aspect oriented programming.

YLHook enables [Aspects](https://github.com/steipete/Aspects) to support functional programming.



## Why to use YLHook

We often write a lot of code to print logs or carry out statistical information everywhere. AOP provides a concise way to solve those [Cross-cutting Concerns](https://en.wikipedia.org/wiki/Cross-cutting_concern).

Aspects Demo:

```objc
[UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
    NSLog(@"[%@]before viewWillAppear",[[aspectInfo instance] class]);
} error:NULL];
```

It's really very simple. But it's not clean when we need hook a lot of methods at one class.

It will be like this:

```objc
[UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
    NSLog(@"[%@]after viewWillAppear",[[aspectInfo instance] class]);
} error:NULL];

[UIViewController aspect_hookSelector:@selector(viewDidLoad:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
    NSLog(@"[%@]before viewDidLoad",[[aspectInfo instance] class]);
} error:NULL];

[UIViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
    NSLog(@"[%@]before viewDidAppear",[[aspectInfo instance] class]);
} error:NULL];
```



Now, you can hook methods by this way:

```objc
[UIViewController yl_makeEvents:^(YLHookEventMaker *make) {
        make.after.sel(viewDidLoad).block(^(id<AspectInfo> aspectInfo){
            NSLog(@"[%@]after viewDidLoad",[[aspectInfo instance] class]);
        });
        make.before.sel(viewWillAppear:).block(^(id<AspectInfo> aspectInfo){
            NSLog(@"[%@]before viewWillAppear",[[aspectInfo instance] class]);
        });
        make.before.sel(viewDidAppear:).block(^(id<AspectInfo> aspectInfo){
            NSLog(@"[%@]before viewDidAppear",[[aspectInfo instance] class]);
        });
  }];
```

This style is like [Masonry](https://github.com/SnapKit/Masonry). In fact, I did refer to Masonry's realization. 



## Usage

You can easy to get an instance of YLHook by static method below:
```objc
+ (YLHook *)hookClass:(Class)cls;
+ (YLHook *)hookClassByName:(NSString *)name;
+ (YLHook *)hookInstance:(id)instance;
```



```objc
[[YLHook hookClassByName:@"UIViewController"] makeEvents:^(YLHookEventMaker *make) {
	make.before.sel(viewDidAppear:).block(^(id<AspectInfo> aspectInfo){
    	NSLog(@"[%@]before viewDidAppear",[[aspectInfo instance] class]);
    });
}];

\\ or
 
[UIViewController yl_makeEvents:^(YLHookEventMaker *make) {
	make.before.sel(viewDidAppear:).block(^(id<AspectInfo> aspectInfo){
    	NSLog(@"[%@]before viewDidAppear",[[aspectInfo instance] class]);
    });
}];
```



The  `excute` of `YLHookEvent` is an optional semantic filler just like `with` in Masonry.

## Installation

If you use Cocoapods, add `pod 'YLHook', '~> 1.0.2'` to  your Podfile.

If not,  drag the two files `YLHook.h/m` into your project. This library relies on [Aspects](https://github.com/steipete/Aspects). And you also need drag `Aspects.h/m` into your project.



## 中文介绍

[链接](http://blog.ypli.xyz/ios/blockzai-han-shu-shi-lian-shi-bian-cheng-zhong-de-ying-yong-you-hua-aopfang-an)



## License

YLHook is released under the MIT license. See [LICENSE](./LICENSE) for details.



## Release Notes

#### Version 1.0.2
- fix bug of `catch`

#### Version 1.0.1

- Use `sel` instead of `selector`. And don't need to wirte `@""` any more.

#### Version 1.0.0

- init