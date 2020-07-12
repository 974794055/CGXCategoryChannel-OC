//
//  CGXScrollMenuChannelControll.h
//  CGXMenu
//
//  Created by CGX on 2017/6/23.
//  Copyright © 2017年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CGXCategoryChannelModel.h"
#import "CGXCategoryChannelViewController.h"
@class CGXCategoryChannelViewController;
@interface CGXCategoryChannelControll : NSObject

+(CGXCategoryChannelControll *)shareControl;
/**
 正在使用的栏目
 */
@property (strong,nonatomic) NSMutableArray<CGXCategoryChannelModel *> *inUseItems;
/**
 可选择的栏目
 */
@property (strong,nonatomic) NSMutableArray<CGXCategoryChannelModel *> *unUseItems;

/**
 显示方法 结束时返回的是正在使用中的频道集合   presentViewController出来
 vc: 当前控制器
 currentInter:当前选中的下标
 channels:选中的菜单
 selectBlock:点击的选项
 */
-(void)showPresentInVC:(UIViewController*)vc
          CurrentInter:(NSInteger)currentInter
            completion:(void (^)(NSMutableArray<CGXCategoryChannelModel *> *inUseItems,NSInteger currentInter))channels
           SelectBlock:(void (^)(CGXCategoryChannelModel *item,NSInteger inter))selectBlock;

/**
 显示方法 结束时返回的是正在使用中的频道集合   presentViewController出来
 channelVC:频道选择vc 设置属性使用
 vc: 当前控制器
 currentInter:当前选中的下标
 channels:选中的菜单
 selectBlock:点击的选项
 */
-(void)showPresentInVC:(UIViewController*)vc
             ChannelVC:(CGXCategoryChannelViewController *)channelVC
          CurrentInter:(NSInteger)currentInter
            completion:(void (^)(NSMutableArray<CGXCategoryChannelModel *> *inUseItems,NSInteger currentInter))channels
           SelectBlock:(void (^)(CGXCategoryChannelModel *item,NSInteger inter))selectBlock;

@end





