//
//  CGXCategoryChannelMoreControll.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2019/5/8.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXCategoryChannelMoreControll.h"

#import "CGXCategoryChannelViewController.h"

#define CGXCategoryChannelMoreControllSavePatch @"CGXCategoryChannelMoreControllSavePatch"

@interface CGXCategoryChannelMoreControll()
{
    NSUserDefaults *_userDefaults;
}
@end

@implementation CGXCategoryChannelMoreControll

+(CGXCategoryChannelMoreControll *)shareControl
{
    static CGXCategoryChannelMoreControll *control = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        control = [[CGXCategoryChannelMoreControll alloc] init];
    });
    return control;
}

-(instancetype)init
{
    if (self = [super init]) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}
/*
 正在使用的栏目
 */
- (NSMutableArray<CGXCategoryChannelModel *> *)showInUseItemsWorkKey:(NSString *)workKey
{
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:[_userDefaults objectForKey:[NSString stringWithFormat:@"%@-%@-1",CGXCategoryChannelMoreControllSavePatch,workKey]]];
    return (array == nil) ? [NSMutableArray array] : array;
}
/*
 可选择的栏目
 */
- (NSMutableArray<CGXCategoryChannelModel *> *)showUnUseItemsWorkKey:(NSString *)workKey
{
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:[_userDefaults objectForKey:[NSString stringWithFormat:@"%@-%@-2",CGXCategoryChannelMoreControllSavePatch,workKey]]];
    return (array == nil) ? [NSMutableArray array] : array;
}
/**
 更新选项
 */
- (void)updateWithinUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)inUseItems unUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)unUseItems WorkKey:(nonnull NSString *)workKey
{
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:inUseItems];
    [_userDefaults setObject:data1 forKey:[NSString stringWithFormat:@"%@-%@-1",CGXCategoryChannelMoreControllSavePatch,workKey]];
    
    NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:unUseItems];
    [_userDefaults setObject:data2 forKey:[NSString stringWithFormat:@"%@-%@-2",CGXCategoryChannelMoreControllSavePatch,workKey]];
    [_userDefaults synchronize];
}

/**
 显示方法 结束时返回的是正在使用中的频道集合   presentViewController出来
 vc: 当前控制器
 currentInter:当前选中的下标
 channels:选中的菜单
 selectBlock:点击的选项
 */
-(void)showPresentInVC:(UIViewController*)vc CurrentInter:(NSInteger)currentInter WorkKey:(NSString *)workKey completion:(void (^)(NSMutableArray<CGXCategoryChannelModel *> *inUseItems,NSInteger currentInter))channels SelectBlock:(void (^)(CGXCategoryChannelModel *item,NSInteger inter))selectBlock
{
    CGXCategoryChannelViewController *channelVC = [[CGXCategoryChannelViewController alloc] init];
    [self showPresentInVC:vc ChannelVC:channelVC CurrentInter:currentInter WorkKey:workKey completion:channels SelectBlock:selectBlock];
}
/**
 显示方法 结束时返回的是正在使用中的频道集合   presentViewController出来
 channelVC:频道选择vc 设置属性使用
 vc: 当前控制器
 currentInter:当前选中的下标
 channels:选中的菜单
 selectBlock:点击的选项
 */
-(void)showPresentInVC:(UIViewController*)vc ChannelVC:(CGXCategoryChannelViewController *)channelVC CurrentInter:(NSInteger)currentInter WorkKey:(NSString *)workKey completion:(void (^)(NSMutableArray<CGXCategoryChannelModel *> *inUseItems,NSInteger currentInter))channels SelectBlock:(void (^)(CGXCategoryChannelModel *item,NSInteger inter))selectBlock
{
    NSMutableArray *inUseItems =  [self showInUseItemsWorkKey:workKey];
    NSMutableArray *unUseItems =  [self showUnUseItemsWorkKey:workKey];
    if (currentInter>inUseItems.count) {
        currentInter = 0;
    }
    [channelVC updateWithinUseItems:inUseItems UnUseItems:unUseItems CurrentInter:currentInter];
    channelVC.saveBlock = ^(NSMutableArray<CGXCategoryChannelModel *> *inUseItems, NSMutableArray<CGXCategoryChannelModel *> *unUseItems, NSInteger currentInter) {
        [[CGXCategoryChannelMoreControll shareControl] updateWithinUseItems:inUseItems unUseItems:unUseItems WorkKey:workKey];
        if (channels){
            channels(inUseItems,currentInter);
        }
    };
    channelVC.selectBlock = ^(CGXCategoryChannelModel *item, NSInteger inter) {
        if (selectBlock) {
            selectBlock(item,inter);
        }
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:channelVC];
    [vc presentViewController:nav animated:true completion:nil];
}

@end

