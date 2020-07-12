//
//  CGXScrollMenuChannelChooseViewController.h
//  CGXAppStructure
//
//  Created by CGX on 2017/6/28.
//  Copyright © 2017年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCategoryChannelControll.h"

#import "CGXCategoryChannelCell.h"
#import "CGXCategoryChannelModel.h"
#import "CGXCategoryChannelHeaderView.h"
#import "CGXCategoryChannelView.h"
//选择后保存的回调 此项不使用，不会改变默认的选项
typedef void(^CGXCategoryChannelViewControllerSaveBlock)(NSMutableArray<CGXCategoryChannelModel *> *inUseItems,NSMutableArray<CGXCategoryChannelModel *> *unUseItems,NSInteger currentInter);

//移动后的回调
typedef void(^CGXCategoryChannelViewControllerMoveBlock)(NSMutableArray<CGXCategoryChannelModel *> *inUseItems,CGXCategoryChannelModel *currentModel,NSInteger currentInter);

//选择点击的选项
typedef void(^CGXCategoryChannelViewControllerSelectBlock)(CGXCategoryChannelModel *item,NSInteger inter);

@interface CGXCategoryChannelViewController : UIViewController

@property (nonatomic , strong,readonly) NSMutableArray<CGXCategoryChannelModel *> *inUseItems;//正在使用
@property (nonatomic , strong,readonly) NSMutableArray<CGXCategoryChannelModel *> *unUseItems;//未使用

@property (nonatomic , assign,readonly) NSInteger currentInter;//当前选择的下标。 默认0
@property (nonatomic , strong) UIColor *bgColor;
@property (nonatomic , strong) NSString *navTitle;
@property (nonatomic , strong) UIColor *navColor;
@property (nonatomic , strong) UIFont *navFont;
@property (nonatomic , assign) NSInteger minimumInter;//默认选择频道最小值 不能拖拽。默认1
/*
 //每个分区的间距是否一致 默认YES 一下三项有效   model里面的设置无效
 */
@property (nonatomic , assign) NSInteger row;//每行的个数。默认 4
@property (nonatomic , assign) CGFloat itemHeight;//每个item的高度 默认是40
@property (nonatomic , assign) CGFloat headerHeight;//分区头的高度 默认是40
@property (nonatomic , assign) CGFloat minimumLineSpacing;//默认是10
@property (nonatomic , assign) CGFloat minimumInteritemSpacing;//默认是10
@property (nonatomic) UIEdgeInsets insets;//默认是10

@property (nonatomic , copy) CGXCategoryChannelViewControllerSaveBlock saveBlock;
@property (nonatomic , copy) CGXCategoryChannelViewControllerSelectBlock selectBlock;
@property (nonatomic , copy) CGXCategoryChannelViewControllerMoveBlock moveBlock;
//返回
-(void)backMethod;

- (void)updateWithinUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)inUseItems UnUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)unUseItems CurrentInter:(NSInteger)currentInter;
@end
