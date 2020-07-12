 //
//  CGXScrollMenuChannelChooseViewController.m
//  CGXAppStructure
//
//  Created by CGX on 2017/6/28.
//  Copyright © 2017年 CGX. All rights reserved.
//

#import "CGXCategoryChannelViewController.h"
#import "CGXCategoryChannelDragCollectionView.h"


@interface CGXCategoryChannelViewController ()

@property (nonatomic , strong,readwrite) NSMutableArray<CGXCategoryChannelModel *> *inUseItems;//正在使用
@property (nonatomic , strong,readwrite) NSMutableArray<CGXCategoryChannelModel *> *unUseItems;//未使用
@property (nonatomic , assign,readwrite) NSInteger currentInter;//当前选择的下标。 默认0
@property (nonatomic , assign) BOOL isChooseMenu;

@property (nonatomic,strong) CGXCategoryChannelView *channelView;

@end

@implementation CGXCategoryChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor =  self.bgColor;
    self.title = self.navTitle ? self.navTitle : @"频道选择";
    self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:self.navColor, NSFontAttributeName:self.navFont};
    
    self.view.backgroundColor = self.bgColor;
    UIImage *aimage = [UIImage imageNamed:@"CGXConfigSlideMenuCancel"];
    UIImage *image = [aimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backMethod)];
    self.navigationItem.leftBarButtonItem = rightItem;
   
    self.channelView = [[CGXCategoryChannelView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-([[UIApplication sharedApplication] statusBarFrame].size.height+44))];
    self.channelView.backgroundColor =  self.bgColor;
    self.channelView.row = self.row;
    self.channelView.itemHeight = self.itemHeight;
    self.channelView.headerHeight = self.headerHeight;
    self.channelView.minimumLineSpacing = self.minimumLineSpacing;
    self.channelView.minimumInteritemSpacing = self.minimumInteritemSpacing;
    self.channelView.minimumInter = self.minimumInter;

    [self.view addSubview:self.channelView];
    __weak typeof(self) weakSelf = self;
    self.channelView.selectBlock = ^(CGXCategoryChannelModel * _Nullable item, NSInteger inter) {
        weakSelf.currentInter = inter;
        [weakSelf backMethod];
        if (weakSelf.selectBlock) {
            weakSelf.selectBlock(item,inter);
        }
    };
    self.channelView.saveBlock = ^(NSMutableArray<CGXCategoryChannelModel *> *inUseItems, NSMutableArray<CGXCategoryChannelModel *> *unUseItems) {
        if (weakSelf.saveBlock) {
            weakSelf.saveBlock(inUseItems, unUseItems,weakSelf.currentInter);
        }
        [weakSelf.inUseItems removeAllObjects];
        [weakSelf.unUseItems removeAllObjects];
        [weakSelf.inUseItems addObjectsFromArray:inUseItems];
        [weakSelf.unUseItems addObjectsFromArray:unUseItems];
    };
    self.channelView.headerBlock = ^(CGXCategoryChannelHeaderView * _Nullable HeaderView) {
        
    };
    self.channelView.moveBlock = ^(NSMutableArray<CGXCategoryChannelModel *> *inUseItems, NSMutableArray<CGXCategoryChannelModel *> * _Nullable unUseItems, NSInteger currentInter) {
        weakSelf.currentInter = currentInter;
        if (weakSelf.saveBlock) {
            weakSelf.saveBlock(inUseItems, unUseItems,currentInter);
        }
        [weakSelf.inUseItems removeAllObjects];
        [weakSelf.unUseItems removeAllObjects];
        [weakSelf.inUseItems addObjectsFromArray:inUseItems];
        [weakSelf.unUseItems addObjectsFromArray:unUseItems];
    };
    
    [self.channelView updateWithinUseItems:self.inUseItems UnUseItems:self.unUseItems CurrentInter:self.currentInter];
    
}
- (void)setInsets:(UIEdgeInsets)insets
{
    _insets = insets;
    self.channelView.insets = insets;
}
- (void)updateWithinUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)inUseItems UnUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)unUseItems CurrentInter:(NSInteger)currentInter
{
    self.currentInter = currentInter;
    [self.inUseItems removeAllObjects];
    [self.unUseItems removeAllObjects];
    [self.inUseItems addObjectsFromArray:inUseItems];
    [self.unUseItems addObjectsFromArray:unUseItems];
    [self.channelView updateWithinUseItems:self.inUseItems UnUseItems:self.unUseItems CurrentInter:self.currentInter];
}
- (void)setCurrentInter:(NSInteger)currentInter
{
    _currentInter = currentInter;
}
- (UIColor *)bgColor
{
    if (!_bgColor) {
        _bgColor = [UIColor whiteColor];
    }
    return _bgColor;
}
- (UIFont *)navFont
{
    if (!_navFont) {
        _navFont = [UIFont systemFontOfSize:18];
    }
    return _navFont;
}
- (UIColor *)navColor
{
    if (!_navColor) {
        _navColor = [UIColor blackColor];
    }
    return _navColor;
}
- (NSMutableArray<CGXCategoryChannelModel *> *)inUseItems
{
    if (!_inUseItems) {
        _inUseItems = [NSMutableArray array];
    }
    return _inUseItems;
}
- (NSMutableArray<CGXCategoryChannelModel *> *)unUseItems
{
    if (!_unUseItems) {
        _unUseItems = [NSMutableArray array];
    }
    return _unUseItems;
}
- (NSInteger)minimumInter
{
    if (!_minimumInter) {
        _minimumInter = 1;
    }
    return _minimumInter;
}
- (CGFloat)minimumInteritemSpacing
{
    if (!_minimumInteritemSpacing) {
        _minimumInteritemSpacing = 5;
    }
    return _minimumInteritemSpacing;
}
- (CGFloat)minimumLineSpacing
{
    if (!_minimumLineSpacing) {
        _minimumLineSpacing = 5;
    }
    return _minimumLineSpacing;
}
- (CGFloat)itemHeight
{
    if (!_itemHeight) {
        _itemHeight = 50;
    }
    return _itemHeight;
}
- (CGFloat)headerHeight
{
    if (!_headerHeight) {
        _headerHeight = 40;
    }
    return _headerHeight;
}
- (NSInteger)row
{
    if (!_row) {
        _row = 4;
    }
    return _row;
}

-(void)backMethod
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
