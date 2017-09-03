# UISearchBarCustom
## 为何基于UISearchBar进行UI个性化？
- UISearchBar默认外观与功能不能满足项目需求
- 利用UISearchDisplayerController或UISearchController的弹出时的转场动画

例如微信的搜索转场动画如下：

![UISearchBar转场动画](https://github.com/RogerHXJ/UISearchBarCustom/blob/master/图片/UISearchBar转场动画.gif)

## UISearchBar个性化思路
项目中多处用到UISearchBar，并且UI效果基本一样，所以直接继承UISearchBar创建一个EPTSearchBar。最后要达到的UI效果如下图所示：

<div align=left><img width="375" height="667" src="https://github.com/RogerHXJ/UISearchBarCustom/blob/master/图片/UISearchBar自定义效果图.PNG"/></div>
## 个性化步骤
1. 继承UISearchBar创建EPTSearchBar
2. 重写initWithFrame:方法，详细的个性化见代码注释

```objc
#import "EPTSearchBar.h"
#import "UIColor+HexString.h"

@implementation EPTSearchBar
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置默认为“搜索”
        self.placeholder = @"搜索";
        // 设置输入光标与取消按钮颜色
        self.tintColor = [UIColor WPLBlueColor];
        // 设置searchBar背景色
        self.barTintColor = [UIColor whiteColor];
        // 设置searchBar背景图片
        [self setBackgroundImage:[UIImage new]];
        // 获取UISearchBar中的textField
        UITextField *textField = [self valueForKey:@"_searchField"];
        // 设置textField的背景色
        CGFloat textFieldBackgroundColorValue = 236 / 255.0;
        UIColor *textFieldBackgroundColor = [UIColor colorWithRed:textFieldBackgroundColorValue green:textFieldBackgroundColorValue blue:textFieldBackgroundColorValue alpha:1];
        textField.backgroundColor = textFieldBackgroundColor;
        // 设置输入文字颜色
        textField.textColor = [UIColor WPLDarkGrayColor];
        // 设置搜索图标
        [self setImage:[UIImage imageNamed:@"search_btn.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        // 设置搜索图标尺寸
        textField.leftView.bounds = CGRectMake(0, 0, 20, 20);
        // 设置清除按钮图片
        [self setImage:[UIImage imageNamed:@"empty_search_btn.png"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
        // 设置语音按钮图片
        [self setImage:[UIImage imageNamed:@"voice_search_btn.png"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
        
        // 添加searchBar底部分割线
        UIView *bottomSeparateView = [UIView new];
        bottomSeparateView.backgroundColor = [UIColor WPLSeparateLineGrayColor];
        bottomSeparateView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:bottomSeparateView];
        [self addConstraints:@[
                               [NSLayoutConstraint constraintWithItem:bottomSeparateView
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0
                                                             constant:0],
                               [NSLayoutConstraint constraintWithItem:bottomSeparateView
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0
                                                             constant:0],
                               [NSLayoutConstraint constraintWithItem:bottomSeparateView
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:0],
                               [NSLayoutConstraint constraintWithItem:bottomSeparateView
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:0.5]
                               ]];

    }
    
    return self;
}
@end
```
**补充说明**

- 自定义设置中首先设置placeholder为"搜索",主要是为了创建UISearchBar中的textField，以便下文中KVC可以获取到这个textField并对它进行自定义设置，这个textField是懒加载创建的。
- 右侧语音按钮，实际是直接利用了提供的bookmark按钮，通过更改bookmark按钮图标实现的，不能直接通过设置textField的rightView实现。
- 默认UISearchBar的placeholder是居中显示的，为了使placeholder靠左显示，使用了一个分类UISearchBar+JCSearchBarPlaceholder

```objc
// 设置靠左显示的placeholder
[self.searchBar changeLeftPlaceholder:@"请输入关键字"];
```

## 第三方轮子引用说明
项目中用到了两个分类，出处如下：

UIColor+HexString: https://github.com/kevinrenskers/UIColor-HexString
UISearchBar+JCSearchBarPlaceholder: https://github.com/624990742/GestureSummary