//
//  CGXCategoryChannelHeaderView.m
//  CGXConfigSlideMenuExample
//
//  Created by CGX on 2018/3/16.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "CGXCategoryChannelHeaderView.h"



@interface CGXCategoryChannelHeaderView()



@end
@implementation CGXCategoryChannelHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.textColor = [UIColor blackColor];
        [self addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(10, 0, 80, frame.size.height);
        
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.detailLabel.textColor = [UIColor lightGrayColor];
        self.detailLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.detailLabel];
        self.detailLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, 120, frame.size.height);
        
        self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.editBtn setTitle:@"完成" forState:UIControlStateSelected];
        [self.editBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.editBtn.layer.masksToBounds = YES;
        self.editBtn.layer.cornerRadius = 6.f;
        self.editBtn.layer.borderColor = [UIColor redColor].CGColor;
        self.editBtn.layer.borderWidth = 1.f;
        self.editBtn.hidden = YES;
        [self addSubview:self.editBtn];
        
        self.editBtn.frame = CGRectMake(frame.size.width-80, 5, 60, frame.size.height-10);
        [self.editBtn addTarget:self action:@selector(headViewEditBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(10, 0, 80, CGRectGetHeight(self.frame));
    self.editBtn.frame = CGRectMake(CGRectGetWidth(self.frame)-70, 5, 60, CGRectGetHeight(self.frame)-10);
     self.detailLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, CGRectGetWidth(self.frame)-CGRectGetMaxX(self.titleLabel.frame)-CGRectGetWidth(self.editBtn.frame)-10, CGRectGetHeight(self.frame));
    
//    self.titleLabel.backgroundColor = [UIColor redColor];
//    self.editBtn.backgroundColor = [UIColor orangeColor];
//    self.detailLabel.backgroundColor = [UIColor blueColor];
}
- (void)headViewEditBtnClick:(UIButton *)sender
{
    sender.selected =!sender.selected;
    if (_editBlock) {
        _editBlock(sender.selected);
    }
}



@end
