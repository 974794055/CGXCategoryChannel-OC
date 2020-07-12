//
//  CGXScrollMenuChannelControll.m
//  CGXMenu
//
//  Created by CGX on 2017/6/23.
//  Copyright © 2017年 CGX. All rights reserved.
//

#import "CGXCategoryChannelControll.h"

#define MenuItemsDic [NSString pathWithComponents:@[NSHomeDirectory(), @"/Documents/CGXCategoryChannelControll"]]
#define InUseItemsPath [NSString pathWithComponents:@[NSHomeDirectory(), @"/Documents/CGXCategoryChannelControll/CGXCategoryChannelControllInUsesItems.plist"]]
#define UnUseItemsPath [NSString pathWithComponents:@[NSHomeDirectory(), @"/Documents/CGXCategoryChannelControll/CGXCategoryChannelControllUnUsesItems.plist"]]



@interface CGXCategoryChannelControll()

@end

@implementation CGXCategoryChannelControll

+(CGXCategoryChannelControll *)shareControl
{
    static CGXCategoryChannelControll *control = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        control = [[CGXCategoryChannelControll alloc] init];
    });
    return control;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self initSavePath];
    }
    return self;
}

-(void)initSavePath
{
    //初始化本文件夹
    if (![[NSFileManager defaultManager] fileExistsAtPath:InUseItemsPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:MenuItemsDic withIntermediateDirectories:true attributes:nil error:nil];
        NSData* data1 = [NSKeyedArchiver archivedDataWithRootObject:[NSMutableArray new]];
        NSData* data2 = [NSKeyedArchiver archivedDataWithRootObject:[NSMutableArray new]];
        [data1 writeToFile:InUseItemsPath atomically:YES];
        [data2 writeToFile:UnUseItemsPath atomically:YES];
    }
//    NSLog(@"本地菜单地址是：%@",InUseItemsPath);
}
#pragma mark -
#pragma mark set/get 方法

-(void)setInUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)inUseItems
{
    [[NSKeyedArchiver archivedDataWithRootObject:inUseItems] writeToFile:InUseItemsPath atomically:YES];
}
-(void)setUnUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)unUseItems
{
    [[NSKeyedArchiver archivedDataWithRootObject:unUseItems] writeToFile:UnUseItemsPath atomically:YES];
}

-(NSMutableArray<CGXCategoryChannelModel *> *)inUseItems
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:InUseItemsPath];
}
-(NSMutableArray<CGXCategoryChannelModel *> *)unUseItems
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:UnUseItemsPath];
}

#pragma mark -
#pragma mark 显示方法

-(void)showPresentInVC:(UIViewController *)vc CurrentInter:(NSInteger)currentInter completion:(void (^)(NSMutableArray<CGXCategoryChannelModel *> *, NSInteger))channels SelectBlock:(void (^)(CGXCategoryChannelModel *, NSInteger))selectBlock
{
    CGXCategoryChannelViewController *channelVC = [[CGXCategoryChannelViewController alloc] init];
    [self showPresentInVC:vc ChannelVC:channelVC CurrentInter:currentInter completion:channels SelectBlock:selectBlock];
}
-(void)showPresentInVC:(UIViewController*)vc ChannelVC:(CGXCategoryChannelViewController *)channelVC CurrentInter:(NSInteger)currentInter completion:(void (^)(NSMutableArray<CGXCategoryChannelModel *> *inUseItems,NSInteger currentInter))channels SelectBlock:(void (^)(CGXCategoryChannelModel *item,NSInteger inter))selectBlock
{
    if (currentInter>[CGXCategoryChannelControll shareControl].inUseItems.count) {
        currentInter = 0;
    }
    [channelVC updateWithinUseItems:[CGXCategoryChannelControll shareControl].inUseItems UnUseItems:[CGXCategoryChannelControll shareControl].unUseItems CurrentInter:currentInter];
    channelVC.saveBlock = ^(NSMutableArray<CGXCategoryChannelModel *> *inUseItems, NSMutableArray<CGXCategoryChannelModel *> *unUseItems, NSInteger currentInter) {
        [CGXCategoryChannelControll shareControl].inUseItems = inUseItems;
        [CGXCategoryChannelControll shareControl].unUseItems = unUseItems;
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
