//
//  FilterCell.m
//  GPUImageDemo
//
//  Created by 邓念 on 2020/6/18.
//  Copyright © 2020 DN. All rights reserved.
//

#import "FilterCell.h"
#import "Masonry.h"

@interface FilterCell()

@property (nonatomic, strong) UILabel *lblContent;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, strong) UIImageView *imgview;
@end

@implementation FilterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.contentView addSubview:self.lblContent];
    [self.contentView addSubview:self.viewLine];
    [self.contentView addSubview:self.imgview];
    
    [_lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-20);
    }];
    
    [_viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    [_imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
}

- (UILabel *)lblContent {
    if (!_lblContent) {
        _lblContent = [[UILabel alloc] init];
        _lblContent.font = [UIFont systemFontOfSize:14];
        _lblContent.textAlignment = NSTextAlignmentLeft;
    }
    return _lblContent;
}

- (UIView *)viewLine {
    if (!_viewLine) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _viewLine;
}
- (UIImageView *)imgview {
    if (!_imgview) {
        _imgview = [[UIImageView alloc] init];
        _imgview.image = [UIImage imageNamed:@"cellarrow"];
    }
    return _imgview;
}

- (void)updateWithCellData:(id)data {
    NSString *strContent = (NSString *)data;
    _lblContent.text = strContent;
}

@end
