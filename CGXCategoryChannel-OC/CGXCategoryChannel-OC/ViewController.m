//
//  ViewController.m
//  CGXCategoryChannel-OC
//
//  Created by CGX on 2019/6/20.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "ViewController.h"
#import "CGXCategoryChannelControll.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"哈哈哈" style:UIBarButtonItemStyleDone target:self action:@selector(selectPop)];
    

    NSMutableArray *dataArray1 = [NSMutableArray array];
    for (int i = 0; i<arc4random() % 10+10; i++) {
        CGXCategoryChannelModel *item = [[CGXCategoryChannelModel alloc] init];
        item.title = [NSString stringWithFormat:@"哈哈-%d" , i];
        [dataArray1 addObject:item];
    }
    NSMutableArray *dataArray2 = [NSMutableArray array];
    for (int i = 0; i<arc4random() % 10+10; i++) {
        CGXCategoryChannelModel *item = [[CGXCategoryChannelModel alloc] init];
        item.title = [NSString stringWithFormat:@"娃哈哈-%d" , i];
        [dataArray2 addObject:item];
    }
    [CGXCategoryChannelControll shareControl].inUseItems = dataArray1;
    [CGXCategoryChannelControll shareControl].unUseItems = dataArray2;
}
- (void)selectPop
{
    [[CGXCategoryChannelControll shareControl] showPresentInVC:self CurrentInter:0 completion:^(NSMutableArray<CGXCategoryChannelModel *> *inUseItems, NSInteger currentInter) {
        
    } SelectBlock:^(CGXCategoryChannelModel *item, NSInteger inter) {
        
    }];
}


@end
