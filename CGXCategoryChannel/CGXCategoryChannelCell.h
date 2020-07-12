//
//  CGXScrollMenuChannelChooseViewCell.h
//  CGXAppStructure
//
//  Created by CGX on 2017/6/27.
//  Copyright © 2017年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCategoryChannelModel.h"
typedef NS_ENUM(NSInteger, CGXScrollMenuChannelChooseViewCellStyle) {
    CGXScrollMenuChannelChooseViewCellNode, //点击选择
    CGXScrollMenuChannelChooseViewCellCancel,   //编辑去处
};

@interface CGXCategoryChannelCell : UICollectionViewCell


//标签栏类型，默认为滚动
@property (nonatomic, assign) CGXScrollMenuChannelChooseViewCellStyle cellType;

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UIImageView *cancelImageview;



/**
 * @b 编辑后, 删除初始选中项排序的回调
 */
@property (nonatomic, copy) void(^removeInitialIndexBlock)(NSMutableArray<CGXCategoryChannelModel *> *topArr, NSMutableArray<CGXCategoryChannelModel *> *bottomArr);

/**
 * @b 选中某一个频道回调
 */
@property (nonatomic, copy) void(^chooseIndexBlock)(NSInteger index, NSMutableArray<CGXCategoryChannelModel *> *topArr, NSMutableArray<CGXCategoryChannelModel *> *bottomArr);

- (void)updateWithModel:(CGXCategoryChannelModel *)model AtIndexPath:(NSIndexPath *)indexPath IsEdit:(BOOL)isEdit IsCurrent:(BOOL)isCurrent;

@end
