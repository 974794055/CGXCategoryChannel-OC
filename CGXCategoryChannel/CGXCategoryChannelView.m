//
//  CGXCategoryChannelView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2019/5/9.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXCategoryChannelView.h"

#ifdef DEBUG
# define NSLogCGXCategoryChannelView(FORMAT, ...) printf("[%s 行号:%d]:\n%s\n\n",__FUNCTION__,__LINE__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
# define NSLogCGXCategoryChannelView(FORMAT, ...)
#endif

@interface CGXCategoryChannelView ()

@property (nonatomic , assign) BOOL isChooseMenu;
@property (strong, nonatomic,readwrite) NSMutableArray <NSMutableArray <CGXCategoryChannelModel *>*>*dataSourceArray;
@property (nonatomic , strong,readwrite) NSMutableArray<CGXCategoryChannelModel *> *inUseItems;//正在使用
@property (nonatomic , strong,readwrite) NSMutableArray<CGXCategoryChannelModel *> *unUseItems;//未使用
@property (nonatomic , assign,readwrite) NSInteger currentInter;//当前选择的下标。 默认0
@property (nonatomic , strong,readwrite) CGXCategoryChannelModel *currentModel;
@property (nonatomic , strong) NSIndexPath *startindexPath;//开始拖拽时位置
@property (nonatomic , strong) NSIndexPath *endindexPath; //结束拖拽时位置


@end
@implementation CGXCategoryChannelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeView];
    }
    return self;
}
- (void)initializeView
{
    self.isChooseMenu = NO;
    self.currentInter = 0;
    self.minimumInter = 1;
    self.insets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.minimumLineSpacing= 5;
    self.minimumInteritemSpacing = 5;
    self.itemHeight = 50;
    self.headerHeight = 40;
    self.row = 4;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
- (void)setCurrentInter:(NSInteger)currentInter
{
    _currentInter = currentInter;
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
//#pragma mark - 创建
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[CGXCategoryChannelDragCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.allowsMultipleSelection = YES;
        _collectionView.dragCellAlpha = 0.9;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = YES;
        //注册cell
        [_collectionView registerClass:[CGXCategoryChannelCell class] forCellWithReuseIdentifier:NSStringFromClass([CGXCategoryChannelCell class])];
        //给collectionView注册头分区的Id
        [_collectionView registerClass:[CGXCategoryChannelHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
        //给collection注册脚分区的id
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerId"];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}
- (NSMutableArray<NSMutableArray<CGXCategoryChannelModel *> *> *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}



- (NSArray *)dataSourceWithDragCellCollectionView:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView {
    return self.dataSourceArray;
}

- (void)dragCellCollectionView:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray {
    self.dataSourceArray = [newDataArray mutableCopy];
}
- (BOOL)dragCellCollectionViewShouldBeginExchange:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (destinationIndexPath.section == 1 || sourceIndexPath.section == 1) {
        return NO;
    }
    if (destinationIndexPath.section == 0 && destinationIndexPath.item < self.minimumInter) {
        if (sourceIndexPath.section == 0 || destinationIndexPath.section == 0) {
            self.startindexPath = sourceIndexPath;
            self.endindexPath= destinationIndexPath;
        }
        return NO;
    }

   
    return YES;
}

- (BOOL)dragCellCollectionViewShouldBeginMove:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath {
    NSLogCGXCategoryChannelView(@"将要开始拖拽时");
    if (indexPath.section == 1) {
        return NO;
    }
    if (indexPath.section == 0 && indexPath.item <self.minimumInter) {
        return NO;
    }
    return YES;
}

- (void)dragCellCollectionViewDidEndDrag:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView {
    NSLogCGXCategoryChannelView(@"dragCellCollectionViewDidEndDrag");
    if (self.startindexPath.section == 0 || self.endindexPath.section == 0) {
        self.inUseItems = self.dataSourceArray[0];
        self.currentInter = [self.inUseItems indexOfObject:self.currentModel];
        [self updateSaveBlock];
        if (self.moveBlock) {
            self.moveBlock(self.inUseItems, self.unUseItems, self.currentInter);
        }
    }
}

- (void)dragCellCollectionView:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView beganDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath {
    NSLogCGXCategoryChannelView(@"beganDragAtPoint %@   - %@", NSStringFromCGPoint(point), indexPath);
    if (!self.isChooseMenu) {
        [self startUpdateEdit:YES];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }
}

- (void)dragCellCollectionView:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView changedDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath {
    
    NSLogCGXCategoryChannelView(@"changedDragAtPoint %@   - %@", NSStringFromCGPoint(point), indexPath);
}

- (void)dragCellCollectionView:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView endedDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath {
    NSLogCGXCategoryChannelView(@"endedDragAtPoint %@   - %@", NSStringFromCGPoint(point), indexPath);
}

- (BOOL)dragCellCollectionView:(CGXCategoryChannelDragCollectionView *)dragCellCollectionView endedDragAutomaticOperationAtPoint:(CGPoint)point section:(NSInteger)section indexPath:(NSIndexPath *)indexPath {
    if (section == 1) {
        // 如果拖到了第一组松开就移动 而且内部不自动处理
        [dragCellCollectionView dragMoveItemToIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
        return NO;
    }
    return YES;
}




#pragma mark - 返回分区的行数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSourceArray.count;
}
#pragma mark - 返回每个分区的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSourceArray[section] count];
}
//#pragma mark UICollectionView Delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(CGRectGetWidth(collectionView.frame), self.headerHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(collectionView.frame), 0);
}
#pragma mark - 定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     NSAssert(self.row > 0, @"每行至少一个item");
    UIEdgeInsets insets  = self.insets;
    CGFloat minimumInteritemSpacing = self.minimumInteritemSpacing;
    CGFloat space = insets.left+insets.right;
    float cellWidth = (collectionView.bounds.size.width-space-(self.row-1)*minimumInteritemSpacing)/self.row;
    return CGSizeMake(cellWidth, self.itemHeight);
}
#pragma mark - 定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.insets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minimumInteritemSpacing;
}
#pragma mark - 显示cell的分区方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CGXCategoryChannelHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId" forIndexPath:indexPath];
        if(view == nil){
            view = [[CGXCategoryChannelHeaderView alloc] init];
        }
        view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        if (indexPath.section == 0) {
            view.editBtn.hidden = NO;
            view.titleLabel.text = @"我的频道";
            view.detailLabel.text = @"点击进入频道";
            if (self.isChooseMenu) {
                view.detailLabel.text = @"拖拽可以排序";
            } else{
                view.detailLabel.text = @"点击进入频道";
            }
            view.editBtn.selected = self.isChooseMenu;
            __weak typeof(self) weakSelf = self;
            view.editBlock = ^(BOOL isChoose) {
                [weakSelf startUpdateEdit:isChoose];
            };
        } else {
            view.editBtn.hidden = YES;
            view.titleLabel.text = @"频道推荐";
            view.detailLabel.text = @"点击添加频道";
        }
        if (self.headerBlock) {
            self.headerBlock(view);
        }
        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerId" forIndexPath:indexPath];
        view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        return view;
    }
}
- (void)startUpdateEdit:(BOOL)edit
{
    self.isChooseMenu = edit;
    if (self.currentInter>=self.inUseItems.count) {
        self.currentInter = self.inUseItems.count-1;
    }
    for (NSInteger inter = 0; inter<[self.dataSourceArray[0] count]; inter++) {
        NSIndexPath *indexPathAA = [NSIndexPath indexPathForItem:inter inSection:0];
        [self.collectionView reloadItemsAtIndexPaths:@[indexPathAA]];
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGXCategoryChannelCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXCategoryChannelCell class]) forIndexPath:indexPath];
    CGXCategoryChannelModel *todayHeadlinesDragModel = self.dataSourceArray[indexPath.section][indexPath.row];
    BOOL isCurrent = NO;
    if (indexPath.section == 0) {
        if (indexPath.row ==  self.currentInter) {
            isCurrent = YES;
        }
    }
    [cell updateWithModel:todayHeadlinesDragModel AtIndexPath:indexPath IsEdit:self.isChooseMenu IsCurrent:isCurrent];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CGXCategoryChannelModel *model = self.dataSourceArray[indexPath.section][indexPath.row];
    if (self.isChooseMenu) {
        if (indexPath.section == 0 && indexPath.item == 0) {
            return;
        }
    } else{
        if (indexPath.section == 0){
            [self updateSaveBlock];
            self.currentInter = indexPath.row;
            self.currentModel = model;
            if (self.selectBlock) {
                self.selectBlock(model,indexPath.row);
            }
            return;
        }
    }
    if (indexPath.section == 0) {
        self.inUseItems = self.dataSourceArray[0];
        [self.inUseItems removeObject:model];
        
        self.unUseItems = self.dataSourceArray[1];
        model.tagType = CGXCategoryChannelModelAdd;
        model.select = NO;
        [self.unUseItems insertObject:model atIndex:0];
        
        
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]]; ;
        [collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:1]]];
    } else {
        self.unUseItems = self.dataSourceArray[1];
        [self.unUseItems removeObject:model];
        
        self.inUseItems = self.dataSourceArray[0];
        model.tagType = CGXCategoryChannelModelNode;
        model.select = YES;
        [self.inUseItems insertObject:model atIndex:self.inUseItems.count];
        
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:self.inUseItems.count-1 inSection:0]];
        [collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:self.inUseItems.count-1 inSection:0]]];
        /** 点击 cell 后取消选中 */
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
    [self updateSaveBlock];
    
}
#pragma mark - collectionViewCell点击高亮

// 高亮时调用
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGXCategoryChannelCell *cell = (CGXCategoryChannelCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.titleLabel.backgroundColor = [UIColor redColor];
//}
//
//// 高亮结束调用
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGXCategoryChannelCell *cell = (CGXCategoryChannelCell *)[collectionView cellForItemAtIndexPath:indexPath];
//     CGXCategoryChannelModel *model = self.dataSourceArray[indexPath.section][indexPath.row];
//    if (model.select) {
//        cell.titleLabel.backgroundColor = model.titleSelectBgColor;
//    } else{
//        cell.titleLabel.backgroundColor = model.titleBgColor;
//    }
//}
//
//// 是否可以高亮
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
- (void)updateWithinUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)inUseItems UnUseItems:(NSMutableArray<CGXCategoryChannelModel *> *)unUseItems CurrentInter:(NSInteger)currentInter
{
    self.currentInter = currentInter;
    self.currentModel = inUseItems[currentInter];
    [self.inUseItems removeAllObjects];
    [self.unUseItems removeAllObjects];
    [self.inUseItems addObjectsFromArray:inUseItems];
    [self.unUseItems addObjectsFromArray:unUseItems];
    
    [self.dataSourceArray removeAllObjects];
    [self.dataSourceArray addObject:self.inUseItems];
    [self.dataSourceArray addObject:self.unUseItems];
    [self.collectionView reloadData];
}
-(void)updateSaveBlock
{
    if (self.saveBlock) {
        self.saveBlock(self.inUseItems, self.unUseItems);
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
