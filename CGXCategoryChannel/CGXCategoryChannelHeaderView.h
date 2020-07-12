//
//  CGXCategoryChannelHeaderView.h
//  CGXConfigSlideMenuExample
//
//  Created by CGX on 2018/3/16.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CGXCategoryChannelHeaderViewEditBlock)(BOOL isChoose);
@interface CGXCategoryChannelHeaderView : UICollectionReusableView


@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
/** 编辑按钮 */
@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic,copy) CGXCategoryChannelHeaderViewEditBlock editBlock;

@end
