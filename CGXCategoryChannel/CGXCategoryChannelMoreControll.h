//
//  CGXCategoryChannelMoreControll.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2019/5/8.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CGXCategoryChannelModel.h"
#import "CGXCategoryChannelViewController.h"

typedef void(^ChannelBlock)(NSArray * _Nonnull channels);

typedef void(^VoidBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryChannelMoreControll : NSObject

+(CGXCategoryChannelMoreControll *)shareControl;

/*
 正在使用的栏目
 */
- (NSMutableArray<CGXCategoryChannelModel *> *)showInUseItemsWorkKey:(NSString *)workKey;
/*
 可选择的栏目
 */
- (NSMutableArray<CGXCategoryChannelModel *> *)showUnUseItemsWorkKey:(NSString *)workKey;

/*
 更新选项   初始化
 inUseItems:正在使用的栏目
 unUseItems:可选择的栏目
 WorkKey:存储的key
 */
- (void)updateWithinUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)inUseItems unUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)unUseItems WorkKey:(NSString *)workKey;

/**
 显示方法 结束时返回的是正在使用中的频道集合   presentViewController出来
 vc: 当前控制器
 currentInter:当前选中的下标
 channels:选中的菜单
 selectBlock:点击的选项
 */
-(void)showPresentInVC:(UIViewController*)vc CurrentInter:(NSInteger)currentInter WorkKey:(NSString *)workKey completion:(void (^)(NSMutableArray<CGXCategoryChannelModel *> *inUseItems,NSInteger currentInter))channels SelectBlock:(void (^)(CGXCategoryChannelModel *item,NSInteger inter))selectBlock;

/**
 显示方法 结束时返回的是正在使用中的频道集合   presentViewController出来
 channelVC:频道选择vc 设置属性使用
 vc: 当前控制器
 currentInter:当前选中的下标
 channels:选中的菜单
 selectBlock:点击的选项
 */
-(void)showPresentInVC:(UIViewController*)vc ChannelVC:(CGXCategoryChannelViewController *)channelVC CurrentInter:(NSInteger)currentInter WorkKey:(NSString *)workKey completion:(void (^)(NSMutableArray<CGXCategoryChannelModel *> *inUseItems,NSInteger currentInter))channels SelectBlock:(void (^)(CGXCategoryChannelModel *item,NSInteger inter))selectBlock;
@end

NS_ASSUME_NONNULL_END
