//
//  CGXScrollMenuChannelChooseViewCell.m
//  CGXAppStructure
//
//  Created by CGX on 2017/6/27.
//  Copyright © 2017年 CGX. All rights reserved.
//

#import "CGXCategoryChannelCell.h"

@implementation CGXCategoryChannelCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width-10,  self.bounds.size.height-10)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _titleLabel.layer.borderWidth = 1;
        _titleLabel.layer.cornerRadius = 4;
        _titleLabel.layer.masksToBounds = YES;
        [_titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_titleLabel];
        
        
        _cancelImageview = [UIImageView new];
        _cancelImageview.image =  [UIImage imageNamed:@"CGXConfigSlideMenuDelect"];
        [self.contentView addSubview:_cancelImageview];
        [self.contentView bringSubviewToFront:_cancelImageview];
        _cancelImageview.frame = CGRectMake(self.bounds.size.width-20, 0, 20, 20);
        
    }
    return self;
}
- (NSString *)imageFilePath:(NSString *)name
{
    NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"CGXConfigSlideMenuExample" ofType:@"bundle"];
    NSString *filePath = [[NSBundle bundleWithPath:strResourcesBundle]
                          pathForResource:name ofType:@"png"];
    return filePath;
}

- (void)setCellType:(CGXScrollMenuChannelChooseViewCellStyle)cellType
{
    _cellType = cellType;
    switch (_cellType) {
        case CGXScrollMenuChannelChooseViewCellNode:
        {
            self.cancelImageview.hidden = YES;
        }
        case CGXScrollMenuChannelChooseViewCellCancel:
        {
            self.cancelImageview.hidden = NO;
        }
        default:
            break;
    }
}
- (void)updateWithModel:(CGXCategoryChannelModel *)model AtIndexPath:(NSIndexPath *)indexPath IsEdit:(BOOL)isEdit IsCurrent:(BOOL)isCurrent
{
     self.cancelImageview.hidden = YES;
    if (model.tagType == CGXCategoryChannelModelNode) {
         self.titleLabel.text = model.title;
    } else{
         self.titleLabel.text = [NSString stringWithFormat:@"＋ %@", model.title];
    }
    if (model.select) {
        self.titleLabel.font = model.titleSelectedFont;
        self.titleLabel.textColor = model.titleSelectedColor;
        self.titleLabel.backgroundColor = model.titleSelectBgColor;
        self.titleLabel.layer.borderColor = model.borderSelectColor.CGColor;
        self.titleLabel.layer.borderWidth = model.borderSelectWidth;
        self.titleLabel.layer.cornerRadius = model.cornerSelectRadius;
    } else{
        self.titleLabel.textColor = model.titleNormalColor;
        self.titleLabel.font = model.titleFont;
        self.titleLabel.backgroundColor = model.titleBgColor;
        self.titleLabel.layer.borderColor = model.borderColor.CGColor;
        self.titleLabel.layer.borderWidth = model.borderWidth;
        self.titleLabel.layer.cornerRadius = model.cornerRadius;;
    }
    if (isCurrent) {
        self.titleLabel.font = model.titleCurrentFont;
        self.titleLabel.textColor = model.titleCurrentColor;
    }
    
    
    self.cancelImageview.hidden = YES;
    if (indexPath.section == 0) {
        if (indexPath.item == 0) {
            self.cancelImageview.hidden = YES;
        } else {
            if (isEdit) {
                self.cancelImageview.hidden = NO;
            } else{
                self.cancelImageview.hidden = YES;
            }
        }
    } else {
        self.cancelImageview.hidden = YES;
    }
}
@end
