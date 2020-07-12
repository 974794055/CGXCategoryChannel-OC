//
//  CGXScrollMenuChannerModel.h
//  CGXMenu
//
//  Created by CGX on 2017/6/23.
//  Copyright © 2017年 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 cell类型
 
 - MyChannel: 我的频道样式 不带“+”的
 - RecommandChannel: 推荐频道样式 带“+”的
 */
typedef NS_ENUM(NSUInteger, CGXCategoryChannelModelType) {
    CGXCategoryChannelModelNode,
    CGXCategoryChannelModelAdd,
};

@interface CGXCategoryChannelModel : NSObject<NSCoding>

/**
 标题
 */
@property (strong,nonatomic) NSString *title;

@property (assign,nonatomic) NSInteger tag;

@property (strong,nonatomic) id dataModel;//原始数据类型

//@property (nonatomic, assign) BOOL currentSelect;

@property (nonatomic, assign) BOOL select;

@property (nonatomic, assign) CGXCategoryChannelModelType tagType;

@property (nonatomic, assign) NSInteger titleNumberOfLines;

@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleCurrentColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *titleCurrentFont;
@property (nonatomic, strong) UIFont *titleSelectedFont;

@property (strong,nonatomic) UIColor *titleBgColor;
@property (strong,nonatomic) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat cornerRadius;


@property (strong,nonatomic) UIColor *titleSelectBgColor;
@property (strong,nonatomic) UIColor *borderSelectColor;
@property (nonatomic, assign) CGFloat borderSelectWidth;
@property (nonatomic, assign) CGFloat cornerSelectRadius;


@end
