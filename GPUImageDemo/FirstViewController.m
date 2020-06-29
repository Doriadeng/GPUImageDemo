//
//  FirstViewController.m
//  GPUImageDemo
//
//  Created by 邓念 on 2020/6/17.
//  Copyright © 2020 DN. All rights reserved.
//

#import "FirstViewController.h"
#import <GPUImageView.h>
#import <GPUImage/GPUImage.h>
#import "Masonry.h"
#import "FilterCell.h"
#import "FilterDetailViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) UIImageView *imgview;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"GPUImageDemo";
    self.navigationController.navigationBar.translucent = NO;
    [self initUI];
    [self initData];
}

- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.tableView.tableFooterView addSubview:self.imgview];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
    [self.imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tableView.tableFooterView).mas_offset(20);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(250);
        make.centerX.mas_equalTo(_tableView.tableFooterView.mas_centerX);
    }];
    
}

- (void)initData {
    self.arrData = @[@"GPUImage3x3ConvolutionFilter",@"GPUImageBoxBlurFilter",@"GPUImageCrosshatchFilter",@"GPUImageColorInvertFilter",@"GPUImageZoomBlurFilter",@"GPUImageLuminanceThresholdFilter"];
}

- (UIImage *)getFilterImage:(GPUImageFilter *)disFilter {
    UIImage *inputImage =[UIImage imageNamed:@"testImg"];
    //创建滤镜
//    GPUImageGlassSphereFilter *disFilter = [[GPUImageGlassSphereFilter alloc] init];
    //设置要渲染的区域
    [disFilter forceProcessingAtSize:inputImage.size];
    [disFilter useNextFrameForImageCapture];
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:inputImage];
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    
    return newImage;
}

#pragma mark property
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[FilterCell class] forCellReuseIdentifier:NSStringFromClass([FilterCell class])];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UIImageView *)imgview {
    if (!_imgview) {
        _imgview = [[UIImageView alloc] init];
        _imgview.image = [UIImage imageNamed:@"testImg"];
    }
    return _imgview;
}
#pragma mark tableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterCell *filterCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FilterCell class]) forIndexPath:indexPath];
    [filterCell updateWithCellData:self.arrData[indexPath.row]];
    return filterCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FilterDetailViewController *nc = [[FilterDetailViewController alloc] init];
    NSString *strName = self.arrData[indexPath.row];
    GPUImageFilter *filter = [[NSClassFromString(strName) alloc] init];
    UIImage *filteredImg = [self getFilterImage:filter];
    nc.image = filteredImg;
    [self.navigationController pushViewController:nc animated:YES];
}
@end
