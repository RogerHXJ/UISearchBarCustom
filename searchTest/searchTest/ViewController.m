//
//  ViewController.m
//  searchTest
//
//  Created by HuangXJ on 2017/8/27.
//  Copyright © 2017年 www.epoint.com.cn Inc. All rights reserved.
//

#import "ViewController.h"
#import "EPTSearchBar.h"
#import "UISearchBar+JCSearchBarPlaceholder.h"

@interface ViewController ()
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"UISearchBar自定义";
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    EPTSearchBar *searchBar = [[EPTSearchBar alloc] init];
    searchBar.frame = CGRectMake(0, 64, screenWidth, 44);
    self.searchBar = searchBar;
    
    // 显示(bookmark)语音按钮
    [self.searchBar setShowsBookmarkButton:YES];
    // 设置靠左显示的placeholder
    [self.searchBar changeLeftPlaceholder:@"请输入关键字"];

    [self.view addSubview:searchBar];
    
}

/*
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for(UIView *subView in self.searchBar.subviews.firstObject.subviews) {
        if([subView isKindOfClass: [UITextField class]]){
            UITextField *searchField = (UITextField *)subView;
            CGFloat myWidth = 26.0f;
            CGFloat myHeight = 30.0f;
            UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, myWidth, myHeight)];
            [myButton setImage:[UIImage imageNamed:@"voice_search_btn.png"] forState:UIControlStateNormal];
            [myButton setImage:[UIImage imageNamed:@"voice_search_btn.png"] forState:UIControlStateHighlighted];
            searchField.rightView = myButton;
            searchField.rightViewMode = UITextFieldViewModeUnlessEditing;
//            searchField.clearButtonMode = UITextFieldViewModeNever;
        }
    }
}
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchBar resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
