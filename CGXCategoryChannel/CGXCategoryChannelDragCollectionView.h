//
//  CGXCategoryChannelDragCollectionView.h
//  CGXMenu
//
//  Created by CGX on 2017/6/23.
//  Copyright © 2017年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGXCategoryChannelDragCollectionView;

#pragma mark - CGXCategoryChannelDragCollectionViewDataSource

/**
 CGXCategoryChannelDragCollectionViewDataSource 协议
 CGXCategoryChannelDragCollectionViewDataSource protocol
 */
@protocol CGXCategoryChannelDragCollectionViewDataSource <UICollectionViewDataSource>

@required

/**
 获取数据源（内部会做合适的更新数据源处理，必须实现）
 Access to data sources (internal will make the appropriate update feed processing, must be implemented)
 
 @param dragCellCollectionView dragCellCollectionView
 @return 返回数据源  return self.dataArray;
 */
- (NSArray *)dataSourceWithDragCellCollectionView:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView;

@end

#pragma mark - CGXCategoryChannelDragCollectionViewDelegate

/**
 CGXCategoryChannelDragCollectionViewDelegate 协议
 CGXCategoryChannelDragCollectionViewDelegate protocol
 */
@protocol CGXCategoryChannelDragCollectionViewDelegate <UICollectionViewDelegateFlowLayout>

@required

/**
 动画和移动完成时（这里会返回更新后的数据源，请在此代理保存数据源，必须实现）
 Animation and movement is complete (here will return the updated data sources, please agent here to save the data source, must be implemented)

 @param dragCellCollectionView dragCellCollectionView
 @param newDataArray 新的数据源，必须保存。 self.dataArray = [newDataArray copy];
 */
- (void)dragCellCollectionView:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray;

@optional

/**
 将要开始拖拽时，询问此位置的Cell是否可以拖拽
 Will begin to drag and drop, asking whether the location of the Cell can drag and drop
 
 @param dragCellCollectionView dragCellCollectionView
 @param indexPath indexPath
 @return YES: 正常拖拽和移动 NO:此Cell不可拖拽，如：增加按钮等。
 */
- (BOOL)dragCellCollectionViewShouldBeginMove:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath;

/**
 将要交换时，询问是否可以交换
 Will exchange, asked if they can exchange
 
 @param dragCellCollectionView dragCellCollectionView
 @param sourceIndexPath 原来的IndexPath
 @param destinationIndexPath 将要交换的IndexPath
 @return YES: 正常拖拽和移动 NO:此Cell不可拖拽，如：增加按钮等。
 */
- (BOOL)dragCellCollectionViewShouldBeginExchange:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

/**
 重排完成时
 Rearrangement complete
 
 @param dragCellCollectionView dragCellCollectionView
 */
- (void)dragCellCollectionViewDidEndDrag:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView;

/**
 开始拖拽时
 Began to drag
 
 @param dragCellCollectionView dragCellCollectionView
 @param point 响应点击
 @param indexPath 响应的indexPath，如果为 nil 说明没有接触到任何 Cell
 */
- (void)dragCellCollectionView:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView beganDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath;

/**
 拖拽改变时
 Drag and drop to change
 
 @param dragCellCollectionView dragCellCollectionView
 @param point 响应点击
 @param indexPath 响应的indexPath，如果为 nil 说明没有接触到任何 Cell
 */
- (void)dragCellCollectionView:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView changedDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath;

/**
 结束拖拽时
 End drag

 @param dragCellCollectionView dragCellCollectionView
 @param point 响应点击
 @param indexPath 响应的indexPath，如果为 nil 说明没有接触到任何 Cell
 */
- (void)dragCellCollectionView:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView endedDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath;

/**
 结束拖拽时时是否内部自动处理
 If end drag and drop all the internal automatic processing
 
 @param dragCellCollectionView dragCellCollectionView
 @param point 响应点击
 @param section 当前触摸的组，如果是 -1 表示没有接触组
 @param indexPath 响应的indexPath，如果为 nil 说明没有接触到任何 Cell
 @return YES: 内部自动操作 NO:外部处理，内部会保持当前的状态，请注意使用
 */
- (BOOL)dragCellCollectionView:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView endedDragAutomaticOperationAtPoint:(CGPoint)point section:(NSInteger)section indexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - CGXCategoryChannelDragCollectionView

/**
 可以长按拖拽Cell的UICollectionView
 UICollectionView can grow by drag and drop the Cell
 */
@interface CGXCategoryChannelDragCollectionView : UICollectionView

@property (nonatomic, weak) id<CGXCategoryChannelDragCollectionViewDelegate> delegate; ///< 代理 delegate
@property (nonatomic, weak) id<CGXCategoryChannelDragCollectionViewDataSource> dataSource; ///< 数据源代理 dataSource

/**
 长按触发时间，默认是0.5秒，建议根据实际情况设值
 To the triggering time long, the default is 0.5 seconds, set value Suggestions according to the actual situation
 */
@property (nonatomic, assign) NSTimeInterval minimumPressDuration;

/**
 是否可以拖拽 默认为YES,
 If you can drag the default to YES,
 
 如果设置为NO，CGXCategoryChannelDragCollectionView 将失去长按拖拽功能和UICollectionView一样
 */
@property (nonatomic, assign, getter=isCanDrag) BOOL canDrag;

/**
 长按拖拽时Cell缩放比例 默认是：1.2
 Long by drag and drop the Cell scaling default is: 1.2
 */
@property (nonatomic, assign) CGFloat dragZoomScale;

/**
 拖拽的Cell在拖拽移动时的透明度 默认是： 1.0
 Drag and drop the Cell in drag move when the transparency The default is 1.0
 */
@property (assign, nonatomic) CGFloat dragCellAlpha;


/**
 移动到指定位置
 To move to the specified location

 @param indexPath 移动到的位置（内部只会处理当前正在拖拽的情况，会把拖拽的Cell 移动到指定位置，建议在停止手势时或者认为适当的时候使用，如：今日头条）
 */
- (void)dragMoveItemToIndexPath:(NSIndexPath *)indexPath;

@end
