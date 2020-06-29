//
//  FilterDetailViewController.m
//  GPUImageDemo
//
//  Created by 邓念 on 2020/6/18.
//  Copyright © 2020 DN. All rights reserved.
//

#import "FilterDetailViewController.h"
#import "Masonry.h"
@interface FilterDetailViewController ()

@property (nonatomic, strong) UIImageView *imgview;
@end

@implementation FilterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imgview];
    
    [_imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(250);
    }];
    _imgview.image = self.image;
}

- (UIImageView *)imgview {
    if (!_imgview) {
        _imgview = [[UIImageView alloc] init];
    }
    return _imgview;
}

@end
