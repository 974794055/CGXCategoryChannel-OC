//
//  CGXScrollMenuChannerModel.m
//  CGXMenu
//
//  Created by CGX on 2017/6/23.
//  Copyright © 2017年 CGX. All rights reserved.
//

#import "CGXCategoryChannelModel.h"

@implementation CGXCategoryChannelModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.tag = [aDecoder decodeIntegerForKey:@"tag"];
    self.tagType = [aDecoder decodeIntegerForKey:@"tagType"];
    self.titleNumberOfLines = [aDecoder decodeIntegerForKey:@"titleNumberOfLines"] ;
    self.titleNormalColor = [aDecoder decodeObjectForKey:@"titleNormalColor"];
    self.titleSelectedColor = [aDecoder decodeObjectForKey:@"titleSelectedColor"];
    self.titleFont = [aDecoder decodeObjectForKey:@"titleFont"];
    self.titleSelectedFont = [aDecoder decodeObjectForKey:@"titleSelectedFont"];
    self.dataModel = [aDecoder decodeObjectForKey:@"dataModel"];
//    self.currentSelect = [aDecoder decodeBoolForKey:@"currentSelect"];
    self.select = [aDecoder decodeBoolForKey:@"select"];
  
    self.titleBgColor = [aDecoder decodeObjectForKey:@"titleBgColor"];
    self.borderColor = [aDecoder decodeObjectForKey:@"borderColor"];
    self.borderWidth = [aDecoder decodeFloatForKey:@"borderWidth"];
    self.cornerRadius = [aDecoder decodeFloatForKey:@"cornerRadius"];
    
    self.titleSelectBgColor = [aDecoder decodeObjectForKey:@"titleSelectBgColor"];
    self.borderSelectColor = [aDecoder decodeObjectForKey:@"borderSelectColor"];
    self.borderSelectWidth = [aDecoder decodeFloatForKey:@"borderSelectWidth"];
    self.cornerSelectRadius = [aDecoder decodeFloatForKey:@"cornerSelectRadius"];
  
    self.titleCurrentColor = [aDecoder decodeObjectForKey:@"titleCurrentColor"];
    self.titleCurrentFont = [aDecoder decodeObjectForKey:@"titleCurrentFont"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeInteger:self.tag forKey:@"tag"];
    [aCoder encodeInteger:self.tagType forKey:@"tagType"];
    [aCoder encodeInteger:self.titleNumberOfLines forKey:@"titleNumberOfLines"];
    [aCoder encodeObject:self.titleNormalColor forKey:@"titleNormalColor"];
    [aCoder encodeObject:self.titleSelectedColor forKey:@"titleSelectedColor"];
    [aCoder encodeObject:self.titleFont forKey:@"titleFont"];
    [aCoder encodeObject:self.titleSelectedFont forKey:@"titleSelectedFont"];
    [aCoder encodeObject:self.dataModel forKey:@"dataModel"];
//    [aCoder encodeBool:self.currentSelect forKey:@"currentSelect"];
    [aCoder encodeBool:self.select forKey:@"select"];
    [aCoder encodeObject:self.titleBgColor forKey:@"titleBgColor"];
    [aCoder encodeObject:self.borderColor forKey:@"borderColor"];
    [aCoder encodeFloat:self.borderWidth forKey:@"borderWidth"];
    [aCoder encodeFloat:self.cornerRadius forKey:@"cornerRadius"];
    [aCoder encodeObject:self.titleSelectBgColor forKey:@"titleSelectBgColor"];
    [aCoder encodeObject:self.borderSelectColor forKey:@"borderSelectColor"];
    [aCoder encodeFloat:self.borderSelectWidth forKey:@"borderSelectWidth"];
    [aCoder encodeFloat:self.cornerSelectRadius forKey:@"cornerSelectRadius"];
    
    [aCoder encodeObject:self.titleCurrentColor forKey:@"titleCurrentColor"];
    [aCoder encodeObject:self.titleCurrentFont forKey:@"titleCurrentFont"];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (instancetype)init
{
    self= [super init];
    if (self) {
        self.tagType = CGXCategoryChannelModelNode;
        self.tag = 0;
        self.titleNumberOfLines = 0;
//        self.currentSelect = NO;
        self.select = NO;
        self.titleNormalColor = [UIColor blackColor];
        self.titleSelectedColor = [UIColor blackColor];
        self.titleFont = [UIFont systemFontOfSize:14];
        self.titleSelectedFont = [UIFont systemFontOfSize:14];
        
        self.titleCurrentColor = [UIColor redColor];
        self.titleCurrentFont = [UIFont systemFontOfSize:14];
        
        self.titleBgColor = [UIColor whiteColor];
        self.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
        self.borderWidth = 1;
        self.cornerRadius = 4;
        
        self.titleSelectBgColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
        self.borderSelectColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
        self.borderSelectWidth = 1;
        self.cornerSelectRadius = 4;
        
    }
    return self;
}


@end
