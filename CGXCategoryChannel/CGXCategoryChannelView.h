//
//  CGXCategoryChannelView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2019/5/9.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCategoryChannelControll.h"
#import "CGXCategoryChannelDragCollectionView.h"

#import "CGXCategoryChannelCell.h"
#import "CGXCategoryChannelModel.h"
#import "CGXCategoryChannelHeaderView.h"

//选择后保存的回调 此项不使用，不会改变默认的选项
typedef void(^CGXCategoryChannelViewSaveBlock)(NSMutableArray<CGXCategoryChannelModel *> * _Nonnull inUseItems,NSMutableArray<CGXCategoryChannelModel *> * _Nullable unUseItems);

//移动后的回调
typedef void(^CGXCategoryChannelViewMoveBlock)(NSMutableArray<CGXCategoryChannelModel *> * _Nullable inUseItems,NSMutableArray<CGXCategoryChannelModel *> * _Nullable unUseItems,NSInteger currentInter);

//选择点击的选项
typedef void(^CGXCategoryChannelViewSelectBlock)(CGXCategoryChannelModel * _Nullable item,NSInteger inter);

//自定义处理头分区
typedef void(^CGXCategoryChannelViewShowHeaderBlock)(CGXCategoryChannelHeaderView * _Nullable HeaderView);



NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryChannelView : UIView
<UICollectionViewDataSource,UICollectionViewDelegate,CGXCategoryChannelDragCollectionViewDelegate, CGXCategoryChannelDragCollectionViewDataSource>

@property (strong, nonatomic,readonly) NSMutableArray <NSMutableArray <CGXCategoryChannelModel *>*>*dataSourceArray;
@property (nonatomic , strong,readonly) NSMutableArray<CGXCategoryChannelModel *> *inUseItems;//正在使用
@property (nonatomic , strong,readonly) NSMutableArray<CGXCategoryChannelModel *> *unUseItems;//未使用

//UICollectionView
@property (nonatomic , strong) CGXCategoryChannelDragCollectionView *collectionView;
@property (nonatomic , strong,readonly) CGXCategoryChannelModel *currentModel;
@property (nonatomic , assign,readonly) NSInteger currentInter;//当前选择的下标。 默认0
@property (nonatomic , assign) NSInteger minimumInter;//默认选择频道最小值 不能拖拽。默认1
@property (nonatomic , assign) NSInteger row;//每行的个数。默认 4 
@property (nonatomic , assign) CGFloat itemHeight;//每个item的高度 默认是40
@property (nonatomic , assign) CGFloat headerHeight;//分区头的高度 默认是40
@property (nonatomic , assign) CGFloat minimumLineSpacing;//默认是10
@property (nonatomic , assign) CGFloat minimumInteritemSpacing;//默认是10
@property (nonatomic) UIEdgeInsets insets;//默认是10

@property (nonatomic , copy) CGXCategoryChannelViewSaveBlock saveBlock;
@property (nonatomic , copy) CGXCategoryChannelViewSelectBlock selectBlock;
@property (nonatomic , copy) CGXCategoryChannelViewShowHeaderBlock headerBlock;
@property (nonatomic , copy) CGXCategoryChannelViewMoveBlock moveBlock;

- (void)updateWithinUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)inUseItems UnUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)unUseItems CurrentInter:(NSInteger)currentInter;

@end

NS_ASSUME_NONNULL_END
